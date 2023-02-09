import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/utility/constants/string_constants.dart';
import 'package:sesimiduy/product/widget/text_field/product_textfield.dart';

class LabeledProductTextField extends StatelessWidget {
  const LabeledProductTextField({
    required this.labelText,
    super.key,
    this.isRequired = true,
    this.isMultiline = false,
  });
  final String labelText;
  final bool isRequired;
  final bool isMultiline;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(labelText: labelText, isRequired: isRequired),
        context.emptySizedHeightBoxLow,
        const ProductTextField(),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    required this.labelText,
    required this.isRequired,
  });

  final String labelText;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: labelText,
        children: [
          TextSpan(
            text: isRequired ? StringConstants.asteriks : '',
            style: context.textTheme.bodyLarge?.copyWith(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
