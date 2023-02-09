import 'package:flutter/material.dart';

import 'package:sesimiduy/core/enums/core_locale.dart';

@immutable
class CoreLocalize {
  final initialPath = 'assets/translations';
  final List<Locale> supportedItems = CoreLocale.supportedLocales;
}
