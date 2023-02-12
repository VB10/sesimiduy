import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:sesimiduy/product/items/colors_custom.dart';

class ButtonNormalText extends StatelessWidget {
  const ButtonNormalText({
    required this.title,
    super.key,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: getValueForScreenType<TextStyle?>(
        context: context,
        mobile: context.textTheme.titleMedium,
        tablet: context.textTheme.titleMedium,
        desktop: context.textTheme.titleLarge,
      )?.copyWith(
        fontWeight: FontWeight.bold,
        color: ColorsCustom.sambacus,
      ),
    );
  }
}
