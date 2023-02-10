import 'package:flutter/material.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';

@immutable
class CustomButtonStyle extends ButtonStyle {
  const CustomButtonStyle._();

  static ButtonStyle get bold {
    return OutlinedButton.styleFrom(
      padding: const PagePadding.verticalSymmetric(),
      side: const BorderSide(
        color: ColorsCustom.sambacus,
        width: 3,
      ),
    );
  }

  static ButtonStyle get normal {
    return ElevatedButton.styleFrom(
      padding: const PagePadding.verticalSymmetric(),
    );
  }
}
