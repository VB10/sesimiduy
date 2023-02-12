import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'package:sesimiduy/product/items/colors_custom.dart';

class ButtonLargeText extends StatelessWidget {
  const ButtonLargeText({
    required this.title,
    super.key,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: context.textTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: ColorsCustom.white,
      ),
    );
  }
}
