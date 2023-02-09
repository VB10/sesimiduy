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
}
