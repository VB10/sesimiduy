import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';

enum CoreLocale {
  en(Locale('en', 'US')),
  tr(Locale('tr', 'TR'));

  final Locale locale;
  // ignore: sort_constructors_first
  const CoreLocale(this.locale);

  static List<Locale> get supportedLocales => [
        const Locale('en', 'US'),
        const Locale('tr', 'TR'),
      ];

  Country get flag {
    switch (this) {
      case CoreLocale.en:
        return Country.us;
      case CoreLocale.tr:
        return Country.tr;
    }
  }

  static CoreLocale fromLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return CoreLocale.en;
      case 'tr':
        return CoreLocale.tr;
      default:
        throw Exception('Unsupported locale: $locale');
    }
  }
}
