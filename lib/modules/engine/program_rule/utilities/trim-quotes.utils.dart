String trimQuotes(String input) {
  bool trimmingComplete = false;
  String beingTrimmed = input;

  while (!trimmingComplete) {
    String beforeTrimming = beingTrimmed.trim();
    beingTrimmed = beingTrimmed.replaceAll(RegExp(r"^'"), '').replaceAll(RegExp(r"'$"), '');
    beingTrimmed = beingTrimmed.replaceAll(RegExp(r'^"'), '').replaceAll(RegExp(r'"$'), '');

    if (beforeTrimming.length == beingTrimmed.length) {
      trimmingComplete = true;
    }
  }
  return beingTrimmed;
}
