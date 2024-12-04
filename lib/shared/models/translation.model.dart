class Translation {
  List<dynamic> translationString;
  late List<TranslationProps> list;

  Translation({required this.translationString}) {
    this.list = List<dynamic>.from(this.translationString)
        .map((translation) => TranslationProps(
            property: translation['property'],
            locale: translation['locale'],
            value: translation['value']))
        .toList();
  }
}

class TranslationProps {
  String property;
  String locale;
  String value;

  TranslationProps(
      {required this.property, required this.locale, required this.value});
}
