import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/decoration/product_text_field_decoration.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: context.colorScheme.onSurface,
      decoration: ProductTextFieldDecoration(context),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
