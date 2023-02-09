// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ProductTextFieldDecoration extends InputDecoration {
  ProductTextFieldDecoration(BuildContext context)
      : super(
          contentPadding: context.paddingLow,
          enabledBorder: focusedBorderStyle(context),
          focusedBorder: focusedBorderStyle(context),
          border: standardBorder(context),
        );

  static OutlineInputBorder focusedBorderStyle(BuildContext context) => OutlineInputBorder(
        borderRadius: context.lowBorderRadius,
        borderSide: BorderSide(color: context.colorScheme.onSurface),
      );

  static OutlineInputBorder standardBorder(BuildContext context) => OutlineInputBorder(
        borderRadius: context.lowBorderRadius,
        borderSide: BorderSide(
          color: context.colorScheme.outline,
          width: context.dynamicWidth(0.1),
        ),
      );
}
