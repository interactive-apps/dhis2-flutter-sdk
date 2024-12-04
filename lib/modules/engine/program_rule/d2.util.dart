bool numberIsFinite(num param) {
  return param.isFinite;
}

bool isNumber(dynamic param) {
  return param is num && numberIsFinite(param);
}

bool isString(dynamic param) {
  return param is String;
}

bool isDefined(dynamic param) {
  return param != null;
}
