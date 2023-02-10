// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';

class ProductTextFieldDecoration extends InputDecoration {
  ProductTextFieldDecoration(BuildContext context, String? hintText)
      : super(
          contentPadding: context.paddingLow,
          enabledBorder: focusedBorderStyle(context),
          focusedBorder: focusedBorderStyle(context),
          border: standardBorder(context),
          hintText: hintText,
          hintStyle: context.textTheme.titleSmall?.copyWith(
            color: ColorsCustom.lightGray,
          ),
        );

  static OutlineInputBorder focusedBorderStyle(BuildContext context) =>
      OutlineInputBorder(
        borderRadius: context.lowBorderRadius,
        borderSide: const BorderSide(
          color: ColorsCustom.lightGray,
        ),
      );

  static OutlineInputBorder standardBorder(BuildContext context) =>
      OutlineInputBorder(
        borderRadius: context.lowBorderRadius,
        borderSide: BorderSide(
          color: ColorsCustom.lightGray,
          width: context.dynamicWidth(0.1),
        ),
      );
}
