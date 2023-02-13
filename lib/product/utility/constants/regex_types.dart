class RegexTypes {
  RegexTypes._();

  static RegExp get firstAndLastName => RegExp(
        r"^([a-zA-Z]{2,}\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)",
      );
}
