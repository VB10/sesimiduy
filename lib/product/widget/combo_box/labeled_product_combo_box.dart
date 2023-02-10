import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/utility/constants/string_constants.dart';
import 'package:sesimiduy/product/widget/combo_box/product_combo_box.dart';

class LabeledProductComboBox<T extends ProductDropDownModel>
    extends StatelessWidget {
  const LabeledProductComboBox({
    required this.labelText,
    super.key,
    this.isRequired = true,
    required this.items,
    required this.onChanged,
    required this.hintText,
    required this.validator,
    this.initialItem,
  });
  final bool isRequired;
  final String labelText;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String hintText;
  final String? Function(T?) validator;
  final T? initialItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(labelText: labelText, isRequired: isRequired),
        context.emptySizedHeightBoxLow,
        ProductComboBox<T>(
          initialItem: initialItem,
          validator: validator,
          hintText: hintText,
          items: items,
          onChanged: onChanged,
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
