import 'package:math_expressions/math_expressions.dart';

class MathExpressions {
  static evaluate(String expression, Map<String, dynamic> data) {
    try {
      RegExp regExp = RegExp(r"#\{(.*?)\}");

      String evaluatedExpression = expression.replaceAllMapped(regExp, (match) {
        String key = match.group(1) ?? '';
        if (data.containsKey(key)) {
          return data[key].toString();
        } else {
          return match.group(0) ?? '';
        }
      });

      Parser parser = Parser();
      Expression parsedExpression = parser.parse(evaluatedExpression);
      ContextModel context = ContextModel();
      return parsedExpression
          .evaluate(EvaluationType.REAL, context)
          .toStringAsFixed(2);
    } catch (e) {
      return expression;
    }
  }

  static bool evaluateExpression(String expression) {
    RegExp regex =
        RegExp(r"(['\`].*?['\`]|\d+)\s*([><!=]=?|==)\s*(['\`].*?['\`]|\d+)");
    final match = regex.firstMatch(expression);

    if (match == null || match.groupCount != 3) {
      return false;
    }

    String leftOperand = match.group(1)!;
    String operator = match.group(2)!;
    String rightOperand = match.group(3)!;

    // Remove quotes if present
    leftOperand = leftOperand.replaceAll("'", "");
    rightOperand = rightOperand.replaceAll("'", "");

    int? leftInt = int.tryParse(leftOperand);
    int? rightInt = int.tryParse(rightOperand);

    if (leftInt != null && rightInt != null) {
      // Both operands are integers
      return evaluateOperation(leftInt, operator, rightInt);
    } else if (leftInt != null) {
      // Only left operand is an integer
      return evaluateOperation(leftInt, operator, rightOperand);
    } else if (rightInt != null) {
      // Only right operand is an integer
      return evaluateOperation(leftOperand, operator, rightInt);
    } else {
      // Neither operand is an integer
      return false;
    }
  }

  static bool evaluateOperation(dynamic left, String operator, dynamic right) {
    switch (operator) {
      case '>':
        return left > right;
      case '<':
        return left < right;
      case '==':
        return left == right;
      case '!=':
        return left != right;
      case '>=':
        return left >= right;
      case '<=':
        return left <= right;
      default:
        return false;
    }
  }
}
