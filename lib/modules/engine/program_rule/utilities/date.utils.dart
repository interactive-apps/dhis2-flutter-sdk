class DateUtils {
  static Duration difference(String firstRulesDate, String secondRulesDate) {
    try {
      final firstDate =
          DateTime.parse(firstRulesDate.replaceAll("'", "").trim());
      final secondDate =
          DateTime.parse(secondRulesDate.replaceAll("'", "").trim());
      return secondDate.difference(firstDate);
    } catch (e) {
      return Duration(days: 0, hours: 0, minutes: 0, seconds: 0);
    }
  }

  static int yearsBetween(String firstRulesDate, String secondRulesDate) {
    return (difference(firstRulesDate, secondRulesDate).inDays / 365).round();
  }

  static weeksBetween(String firstRulesDate, String secondRulesDate) {
    return (difference(firstRulesDate, secondRulesDate).inDays / 7).round();
  }

  static int daysBetween(String firstRulesDate, String secondRulesDate) {
    return difference(firstRulesDate, secondRulesDate).inDays;
  }

  static int monthsBetween(String firstRulesDate, String secondRulesDate) {
    return (difference(firstRulesDate, secondRulesDate).inDays / 30).round();
  }
}
