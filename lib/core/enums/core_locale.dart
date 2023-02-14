import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';

enum CoreLocale {
  en(Locale('en', 'US')),
  ar(Locale('ar', 'AR')),
  tr(Locale('tr', 'TR'));

  final Locale locale;
  // ignore: sort_constructors_first
  const CoreLocale(this.locale);

  static final List<Locale> supportedLocales =
      CoreLocale.values.map((e) => e.locale).toList();

  Country get flag {
    switch (this) {
      case CoreLocale.en:
        return Country.us;
      case CoreLocale.tr:
        return Country.tr;

      case CoreLocale.ar:
        return Country.ar;
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
