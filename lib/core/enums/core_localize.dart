import 'package:flutter/material.dart';

@immutable
class CoreLocalize {
  final initialPath = 'assets/translations';
  final List<Locale> supportedItems = [
    const Locale(
      'tr',
      'TR',
    ),
  ];
}
