import 'package:dhis2_flutter_sdk/modules/engine/program_rule/data_value_entities.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_rule.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_rule_action.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_rule_variable.entity.dart';
import 'package:expressions/expressions.dart';

class ProgramRuleEngine {
  static getEvaluationContext(
      {required Map<String, DataValueObject> dataValueEntities,
      required List<ProgramRuleVariable> programRuleVariables}) {
    Map<String, dynamic> evaluationContext = {};

    programRuleVariables.forEach((programRuleVariable) {
      final value = dataValueEntities[
              programRuleVariable.trackedEntityAttribute ??
                  programRuleVariable.dataElement]
          ?.value;

      evaluationContext = {
        ...evaluationContext,
        "${programRuleVariable.name}": value
      };
    });

    return evaluationContext;
  }

  static List<ProgramRuleAction> execute(
      {required Map<String, DataValueObject> dataValueEntities,
      required List<ProgramRule> programRules,
      required List<ProgramRuleVariable> programRuleVariables}) {
    List<ProgramRuleAction> programRulesActions = [];

    Map<String, dynamic> evaluationContext =
        ProgramRuleEngine.getEvaluationContext(
            dataValueEntities: dataValueEntities,
            programRuleVariables: programRuleVariables);

    programRules.forEach((programRule) {
      final ruleConditionForEvaluation = programRule.condition
          .replaceAll("#{", "")
          .replaceAll("A{", "")
          .replaceAll("}", "");

      try {
        Expression expression = Expression.parse(ruleConditionForEvaluation);

        final evaluator = const ExpressionEvaluator();
        var evaluationResult = evaluator.eval(expression, evaluationContext);

        final newProgramRuleActions =
            programRule.programRuleActions?.map((ruleAction) {
          return ProgramRuleAction.fromJson({
            ...ruleAction.toJson(),
            'programRuleActionType':
                evaluationResult == true ? ruleAction.programRuleActionType : ""
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

    return programRulesActions;
  }
}
