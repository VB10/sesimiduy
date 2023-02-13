import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';

class ActiveButton extends StatelessWidget {
  const ActiveButton({super.key, required this.label, required this.onPressed});
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const PagePadding.generalAllNormal(),
        backgroundColor: ColorsCustom.sambacus,
      ),
      child: Text(
        label,
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: onPressed == null
              ? ColorsCustom.sambacus.withOpacity(0.5)
              : Colors.white,
        ),
      ),
    );
  }
}
