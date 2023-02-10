import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/decoration/product_text_field_decoration.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField({
    super.key,
    this.isMultiline = false,
    required this.validator,
    this.formatters,
    this.hintText,
  });
  final bool isMultiline;
  final String? Function(String?) validator;
  final List<TextInputFormatter>? formatters;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      inputFormatters: formatters,
      maxLines: isMultiline ? AppConstants.kFour : AppConstants.kOne,
      cursorColor: context.colorScheme.onSurface,
      decoration: ProductTextFieldDecoration(context, hintText),
      validator: validator,
    );
  }
}
