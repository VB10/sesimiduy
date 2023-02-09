import 'package:flutter/material.dart';

enum LocalizatonLocales { init, en, tr }

extension LocalizatonLocalesExtension on LocalizatonLocales {
  Locale get rawValue {
    switch (this) {
      case LocalizatonLocales.en:
        return const Locale('en', 'US');
      case LocalizatonLocales.tr:
      case LocalizatonLocales.init:
        return const Locale('tr', 'TR');
      default:
        return const Locale('tr', 'TR');
    }
  }

  List<Locale> get supportedLocales =>
      [const Locale('en', 'US'), const Locale('tr', 'TR')];
}
