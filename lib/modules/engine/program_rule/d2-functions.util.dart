import 'package:d2_touch/modules/engine/program_rule/utilities/date.utils.dart';

final List<D2Function> d2FunctionsVariables = [
  D2Function('d2:daysBetween', parameters: 2),
];

final Map<String, Function> d2FunctionsEval = {
  'd2:daysBetween': (
    String expression,
    List<String> parameters,
    Map<String, dynamic> variableHash,
    String regexFunct,
  ) {
    final date1 = removeQuotes(parameters[0]);
    final date2 = removeQuotes(parameters[1]);

    final daysBetween = DateUtils.daysBetween(date1, date2);
    final newExpression = expression.replaceFirst(regexFunct, '$daysBetween');
    return {'expression': newExpression, 'expressionUpdated': true};
  },
};

class D2Function {
  final String name;
  final int? parameters;

  D2Function(this.name, {this.parameters});
}

String removeQuotes(String input) {
  return input.replaceAll(RegExp(r"[']"), "").replaceAll(RegExp(r'["]'), "");
}
