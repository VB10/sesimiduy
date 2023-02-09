import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/widget/text_field/product_textfield.dart';

class LabeledProductTextField extends StatelessWidget {
  const LabeledProductTextField({super.key, required this.labelText});
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Label(labelText: labelText),
        const ProductTextField(),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    required this.labelText,
  });

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText,
      style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurface),
    );
  }
}
