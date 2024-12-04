import 'package:d2_touch/modules/engine/program_rule/utilities/date.utils.dart';

String d2hasValue(String expression) {
  RegExp hasValueRegex = RegExp(r'd2:hasValue\(([^)]+)\)');
  String replaceHasValue(Match match) {
    String content = match.group(1)?.trim() ?? '';
    if (content.trim().contains("''")) {
      return '1 == 0';
    } else {
      return '1 == 1';
    }
  }

  return expression
      .replaceAll('d2:hasValue(' ')', '1 == 0')
      .replaceAllMapped(hasValueRegex, (match) => replaceHasValue(match));
}

String d2Length(String expression) {
  RegExp hasValueRegex = RegExp(r'd2:length\(([^)]+)\)');
  String replaceHasValue(Match match) {
    String content = match.group(1)?.trim() ?? '';
    if (content.trim().contains("''")) {
      return '0';
    } else {
      return '${content.length}';
    }
  }

  String value = '';

  expression.replaceAllMapped(hasValueRegex, (match) {
    value = replaceHasValue(match);
    return value;
  });

  return value;
}

String dhisD2Functions(String expression) {
  String updatedExpression = expression;

  RegExp regex = RegExp(r'd2:(\w+)\((.*?)\)');

  String replaceMatch(Match match) {
    String d2Argument = match.group(1) ?? '';
    String d2Value = match.group(2) ?? '';

    switch (d2Argument) {
      case 'hasValue':
        return d2hasValue(expression);
      case 'length':
        return d2Length(expression);
      case 'daysBetween':
        List<String> dates = d2Value.split(',');
        return DateUtils.daysBetween(dates[0], dates[1]).toString();
      case 'yearsBetween':
        List<String> dates = d2Value.split(',');
        return DateUtils.yearsBetween(dates[0], dates[1]).toString();
      case 'monthsBetween':
        List<String> dates = d2Value.split(',');
        return DateUtils.monthsBetween(dates[0], dates[1]).toString();
      default:
        return d2Value;
    }
  }

  // Replace all matches in the expression
  updatedExpression =
      expression.replaceAllMapped(regex, (match) => replaceMatch(match));

  updatedExpression = updatedExpression
      .replaceAll(r"!''", '1 == 1')
      .replaceAll('d2:length(' ')', '0')
      .replaceAll('d2:length( ' ' )', '0');

  RegExp notValueRegex = RegExp(r'!([^"]+)', caseSensitive: false);

  updatedExpression =
      updatedExpression.replaceAllMapped(notValueRegex, (match) {
    String content = match.group(1)?.trim() ?? '';
    if (content.isNotEmpty) {
      return '1 == 0';
    } else {
      return match.group(0) ?? '';
    }
  });

  return updatedExpression;
}

Iterable<Match> getMatches(String inputString, String name) {
  RegExp regex = RegExp(name +
      r"\(((\d[\d/*+%-.\s]*)|(\'[^\']*\')) *, *((\d[\d/*+%-.\s]*)|(\'[^\']*\'))\)");
  return regex.allMatches(inputString);
}

bool runRuleExpressions(
    String expression, String beforeReplacement, String identifier) {
  try {
    dynamic canEvalRule = dhisD2Functions(expression);
    return canEvalRule;
  } catch (e) {
    return false;
  }
}
