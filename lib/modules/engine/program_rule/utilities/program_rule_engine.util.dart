import 'package:d2_touch/modules/engine/program_rule/models/math_expressions.dart';
import 'package:d2_touch/modules/engine/program_rule/run-d2-expression.util.dart';
import 'package:d2_touch/modules/engine/shared/utilities/data_value_entities.util.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule_action.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule_variable.entity.dart';
import 'package:expressions/expressions.dart';

class ProgramRuleEngine {
  static _getEvaluationContext(
      {required Map<String, DataValueObject> dataValueEntities,
      required List<ProgramRuleVariable> programRuleVariables,
      Map<String, dynamic> additionalValues = const {}}) {
    Map<String, dynamic> evaluationContext = {};

    programRuleVariables.forEach((programRuleVariable) {
      final value = dataValueEntities[
              programRuleVariable.trackedEntityAttribute ??
                  programRuleVariable.dataElement]
          ?.value;

      evaluationContext = {
        ...evaluationContext,
        ...additionalValues,
        "${programRuleVariable.name}": value
      };
    });

    return evaluationContext;
  }

  static _parseRuleValue(value) {
    if (value == null) {
      return "'" + "'";
    }

    bool isDouble = false;

    try {
      double.parse(value);
      isDouble = true;
    } catch (e) {}

    if (isDouble) {
      return value;
    }

    bool isInt = false;
    try {
      int.parse(value);
      isInt = true;
    } catch (e) {}

    if (isInt) {
      return value;
    }

    return "'$value'";
  }

  static addDataToExpression(
      String expression, Map<String, dynamic> evaluationContext) {
    evaluationContext.keys.forEach((key) {
      final value = evaluationContext[key];
      expression = expression.replaceAll(
          "#{" + key + "}", ProgramRuleEngine._parseRuleValue(value));

      expression = expression.replaceAll(
          "A{" + key + "}", ProgramRuleEngine._parseRuleValue(value));

      expression = expression.replaceAll(
          "V{" + key + "}", ProgramRuleEngine._parseRuleValue(value));
    });
    return expression;
  }

  static evaluateD2Data(data, evaluationContext) {
    return dhisD2Functions(addDataToExpression(data, evaluationContext));
  }

  static List<ProgramRuleAction> execute(
      {required Map<String, DataValueObject> dataValueEntities,
      required List<ProgramRule> programRules,
      required List<ProgramRuleVariable> programRuleVariables,
      Map<String, dynamic> additionalValues = const {}}) {
    List<ProgramRuleAction> programRulesActions = [];

    try {
      Map<String, dynamic> evaluationContext =
          ProgramRuleEngine._getEvaluationContext(
              dataValueEntities: dataValueEntities,
              additionalValues: additionalValues,
              programRuleVariables: programRuleVariables);

      programRules.forEach((programRule) {
        String ruleConditionForEvaluation = programRule.condition;

        ruleConditionForEvaluation =
            addDataToExpression(ruleConditionForEvaluation, evaluationContext);

        ruleConditionForEvaluation = ruleConditionForEvaluation
            .replaceAll(RegExp(r'[A|V|#]\{.*?\}'), "''")
            .replaceAll('d2:length( ' ' )', '0')
            .replaceAll('d2:length(' ')', '0')
            .replaceAll(r"!''", '1 == 1');

        if (ruleConditionForEvaluation.contains('d2:')) {
          ruleConditionForEvaluation =
              dhisD2Functions(ruleConditionForEvaluation);
        }

        try {
          if (ruleConditionForEvaluation.contains('d2:')) {
            ruleConditionForEvaluation =
                dhisD2Functions(ruleConditionForEvaluation);
          }
          ruleConditionForEvaluation =
              ruleConditionForEvaluation.replaceAll("''", '0');

          dynamic evaluationResult;
          try {
            Expression expression =
                Expression.parse(ruleConditionForEvaluation);
            final evaluator = const ExpressionEvaluator();
            evaluationResult = evaluator.eval(expression, evaluationContext);
          } catch (e) {}

          final newProgramRuleActions =
              programRule.programRuleActions?.map((ruleAction) {
            String data = ruleAction.data ?? '';
            dynamic result =
                data != '' && evaluationResult == true && data.contains('#{')
                    ? MathExpressions.evaluate(data, evaluationContext)
                    : data.contains('d2:') && evaluationResult == true
                        ? evaluateD2Data(data, evaluationContext)
                        : evaluationResult == true
                            ? data
                            : '';

            return ProgramRuleAction.fromJson({
              ...ruleAction.toJson(),
              'data': result,
              'programRuleActionType': evaluationResult == true
                  ? ruleAction.programRuleActionType
                  : ""
            });
          }).toList();

          programRulesActions = List.from([
            ...programRulesActions,
            ...(newProgramRuleActions as List<ProgramRuleAction>)
          ]);
        } catch (e) {
          final newProgramRuleActions =
              programRule.programRuleActions?.map((ruleAction) {
            return ProgramRuleAction.fromJson(
                {...ruleAction.toJson(), 'programRuleActionType': ''});
          }).toList();

          programRulesActions = List.from([
            ...programRulesActions,
            ...(newProgramRuleActions as List<ProgramRuleAction>)
          ]);
        }
      });
    } catch (e) {}
    return programRulesActions;
  }
}
