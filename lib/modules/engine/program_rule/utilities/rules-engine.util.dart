import 'package:d2_touch/modules/engine/program_rule/utilities/trim-quotes.utils.dart';
import 'package:intl/intl.dart';

String addQuotesToString(value) =>
    (value is num) ? value.toString() : "'$value'";

String processValue(value, String type) {
  if (value is String) {
    value = trimQuotes(value);
  }

  var mapTypeToInterfaceFnName;
  final convertFnName = mapTypeToInterfaceFnName[type];
  if (convertFnName == null) {
    // log.warn('Error in converting this value of type $type');
    return value.toString();
  }

  final convertedValue =
      addQuotesToString(functionConvertors[convertFnName]!(value));
  return convertedValue;
}

final String dateMomentFormat = 'yyyy-MM-dd';

final Map<String, Function> functionConvertors = {
  'convertText': (dynamic value) => value ?? '',
  'convertLongText': (dynamic value) => value ?? '',
  'convertLetter': (dynamic value) => value ?? '',
  'convertPhoneNumber': (dynamic value) => value ?? '',
  'convertEmail': (dynamic value) => value ?? '',
  'convertBoolean': (dynamic value) => value ?? value == false ? value : '',
  'convertTrueOnly': (dynamic value) => value ?? value == false ? value : '',
  'convertDate': (dynamic value) {
    if (value == null) {
      return '';
    }
    final DateTime dateValue = DateTime.parse(value);
    final formattedDate = DateFormat(dateMomentFormat).format(dateValue);
    return formattedDate;
  },
  'convertDateTime': (dynamic value) => value ?? '',
  'convertTime': (dynamic value) => value ?? '',
  'convertNumber': (dynamic value) => num.tryParse(value.toString()) ?? '',
  'convertInteger': (dynamic value) => value ?? value == 0 ? value : '',
  'convertIntegerPositive': (dynamic value) => value ?? value == 0 ? value : '',
  'convertIntegerNegative': (dynamic value) => value ?? value == 0 ? value : '',
  'convertIntegerZeroOrPositive': (dynamic value) =>
      value ?? value == 0 ? value : '',
  'convertPercentage': (dynamic value) => value ?? value == 0 ? value : '',
  'convertUrl': (dynamic value) => value ?? '',
  'convertAge': (dynamic value) => functionConvertors['convertDate']!(value),
};
