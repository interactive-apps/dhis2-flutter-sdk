import 'dart:convert';

import 'package:d2_touch/modules/data/aggregate/entities/data_value.entity.dart';
import 'package:d2_touch/modules/data/aggregate/entities/data_value_set.entity.dart';
import 'package:d2_touch/modules/data/aggregate/queries/data_value.query.dart';
import 'package:d2_touch/modules/engine/shared/utilities/data_value_entities.util.dart';
import 'package:d2_touch/modules/engine/validation_rule/models/validation_rule_action.model.dart';
import 'package:d2_touch/modules/engine/validation_rule/models/validation_rule_result.model.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/validation_rule.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/validation_rule.query.dart';
import 'package:expressions/expressions.dart';
import 'package:sqflite/sqflite.dart';

class ValidationRuleEngine {
  late Database database;
  ValidationRuleEngine({required this.database});
  Future<ValidationRuleResult> execute(
      {required DataValueSet dataValueSet,
      required String dataSet,
      DataValue? changedDataValue}) async {
    List<ValidationRuleAction> validationRuleActions = [];

    List<ValidationRule> validationRules =
        await ValidationRuleQuery(database: database)
            .where(attribute: 'dataSet', value: dataSet)
            .get();

    List<DataValue> dataValues = await DataValueQuery(database: database)
        .where(attribute: 'dataValueSet', value: dataValueSet.id)
        .get();

    final dataValueEntities =
        DataValueEntities.fromAggregateDataValues(dataValues);

    final nonTotalEvaluationContext =
        ValidationRuleEngine._getEvaluationContext(dataValueEntities);

    final totalEvaluationContext = ValidationRuleEngine._getEvaluationContext(
        dataValueEntities,
        totalOnly: true);

    validationRules.forEach((validationRule) {
      final leftSide = jsonDecode(json.decode(validationRule.leftSide));

      String leftSideConditionForEvaluation = leftSide['expression']
          .replaceAll("#{", "")
          .replaceAll("}", "")
          .replaceAll(".", "");

      List<String> leftSideElements = leftSide['expression']
          .replaceAll("#{", ",")
          .replaceAll("}", ",")
          .split(',')
          .where((String id) => id.length > 0)
          .toList();

      final rightSide = jsonDecode(json.decode(validationRule.rightSide));
      String rightSideConditionForEvaluation = rightSide['expression']
          .replaceAll("#{", "")
          .replaceAll("}", "")
          .replaceAll(".", "");

      List<String> rightSideElements = rightSide['expression']
          .replaceAll("#{", ",")
          .replaceAll("}", ",")
          .split(',')
          .where((String id) => id.length > 0)
          .toList();

      nonTotalEvaluationContext.keys.forEach((key) {
        final value = nonTotalEvaluationContext[key];

        leftSideConditionForEvaluation =
            leftSideConditionForEvaluation.replaceAll(key, value);
        rightSideConditionForEvaluation =
            rightSideConditionForEvaluation.replaceAll(key, value);
      });

      totalEvaluationContext.keys.forEach((key) {
        final value = totalEvaluationContext[key];

        leftSideConditionForEvaluation =
            leftSideConditionForEvaluation.replaceAll(key, value);
        rightSideConditionForEvaluation =
            rightSideConditionForEvaluation.replaceAll(key, value);
      });

      bool skipLeftSideExpression = false;
      try {
        Expression leftSideExpression =
            Expression.parse(leftSideConditionForEvaluation);
        final leftSideEvaluator = const ExpressionEvaluator();
        leftSideEvaluator.eval(leftSideExpression, nonTotalEvaluationContext);
      } catch (e) {
        skipLeftSideExpression =
            leftSide['missingValueStrategy'] == 'SKIP_IF_ANY_VALUE_MISSING';
      }

      bool skipRightSideExpression = false;
      try {
        Expression rightSideExpression =
            Expression.parse(rightSideConditionForEvaluation);
        final rightSideEvaluator = const ExpressionEvaluator();
        rightSideEvaluator.eval(rightSideExpression, nonTotalEvaluationContext);
      } catch (e) {
        skipRightSideExpression =
            rightSide['missingValueStrategy'] == 'SKIP_IF_ANY_VALUE_MISSING';
      }

      if (!(skipLeftSideExpression || skipRightSideExpression)) {
        String ruleExpressionForEvaluation =
            '$leftSideConditionForEvaluation ${ValidationRuleEngine._getRuleMathOperator(validationRule.operator)} $rightSideConditionForEvaluation';

        try {
          Expression expression = Expression.parse(ruleExpressionForEvaluation);

          final evaluator = const ExpressionEvaluator();
          var evaluationResult =
              evaluator.eval(expression, nonTotalEvaluationContext);

          if (evaluationResult == false) {
            validationRuleActions.add(ValidationRuleAction(
                instruction: (validationRule.displayInstruction ??
                    validationRule.instruction ??
                    validationRule.name) as String,
                dataElements: [...leftSideElements, ...rightSideElements],
                action: 'SHOWWARNING'));
          }
        } catch (e) {}
      }
    });

    return ValidationRuleResult(
        dataValueSet: dataValueSet,
        validationRuleActions: validationRuleActions);
  }

  static _getEvaluationContext(Map<String, DataValueObject> dataValueEntities,
      {bool totalOnly = false}) {
    Map<String, dynamic> evaluationContext = {};

    dataValueEntities.keys.forEach((key) {
      if (totalOnly) {
        evaluationContext[key.split('.')[0]] = dataValueEntities[key]?.value;
      } else {
        evaluationContext[key.replaceAll(".", "")] =
            dataValueEntities[key]?.value;
      }
    });

    return evaluationContext;
  }

  static String _getRuleMathOperator(String operator) {
    switch (operator) {
      case 'less_than_or_equal_to':
        return '<=';
      case 'less_than':
        return '<';
      case 'greater_than_or_equal_to':
        return '>=';
      case 'greater_than':
        return '>';
      case 'equal':
        return '==';
      case 'not_equal':
        return '!=';
      default:
        return operator;
    }
  }
}
