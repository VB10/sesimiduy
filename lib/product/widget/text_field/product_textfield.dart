import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/decoration/product_text_field_decoration.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField({
    required this.validator,
    super.key,
    this.isMultiline = false,
    this.formatters,
    this.hintText,
    this.keyboardType,
  });
  final bool isMultiline;
  final String? Function(String?) validator;
  final List<TextInputFormatter>? formatters;
  final String? hintText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formatters,
      keyboardType: keyboardType,
      maxLines: isMultiline ? AppConstants.kFour : AppConstants.kOne,
      cursorColor: context.colorScheme.onSurface,
      decoration: ProductTextFieldDecoration(context, hintText),
      validator: validator,
    );
  }
}
