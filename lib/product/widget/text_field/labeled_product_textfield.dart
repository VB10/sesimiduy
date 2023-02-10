import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/utility/constants/string_constants.dart';
import 'package:sesimiduy/product/widget/text_field/product_textfield.dart';

class LabeledProductTextField extends StatelessWidget {
  const LabeledProductTextField({
    required this.validator,
    required this.labelText,
    super.key,
    this.isRequired = true,
    this.isMultiline = false,
    this.formatters,
    this.hintText,
    this.keyboardType,
  });
  final String labelText;
  final bool isRequired;
  final bool isMultiline;
  final String? Function(String?) validator;
  final List<TextInputFormatter>? formatters;
  final String? hintText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(labelText: labelText, isRequired: isRequired),
        context.emptySizedHeightBoxLow,
        ProductTextField(
          hintText: hintText,
          formatters: formatters,
          isMultiline: isMultiline,
          validator: validator,
          keyboardType: keyboardType ?? TextInputType.text,
        ),
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
        text: '$labelText ',
        style: context.textTheme.labelLarge?.copyWith(
          color: Colors.black,
        ),
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
