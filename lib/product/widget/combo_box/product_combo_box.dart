// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/widget_size.dart';

class ProductComboBox<T extends ProductDropDownModel> extends StatefulWidget {
  const ProductComboBox({
    required this.items,
    super.key,
    required this.onChanged,
    required this.hintText,
    required this.validator,
    this.initialItem,
  });
  final List<T> items;

  final ValueChanged<T?> onChanged;
  final String hintText;
  final String? Function(T?) validator;
  final T? initialItem;

  @override
  State<ProductComboBox<T>> createState() => _ProductComboBoxState<T>();
}

class _ProductComboBoxState<T extends ProductDropDownModel>
    extends State<ProductComboBox<T>> {
  T? selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialItem;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsCustom.lightGray,
        ),
        borderRadius:
            const BorderRadius.all(Radius.circular(WidgetSizes.spacingXxs)),
      ),
      child: Padding(
        padding: const PagePadding.allVeryLow(),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<T>(
            decoration: const InputDecoration.collapsed(hintText: ''),
            value: selectedItem,
            hint: Text(widget.hintText),
            isExpanded: true,
            borderRadius: context.lowBorderRadius,
            validator: widget.validator,
            items:
                widget.items.map((e) => _ProductDropdownItem(item: e)).toList(),
            onChanged: (value) {
              selectItem(value);
              widget.onChanged(value);
            },
          ),
        ),
      ),
    );
  }

  void selectItem(T? value) {
    setState(() {
      selectedItem = value;
    });
  }
}

class _ProductDropdownItem<T extends ProductDropDownModel>
    extends DropdownMenuItem<T> {
  _ProductDropdownItem({required T item})
      : super(
          child: Text(item.name ?? ''),
          value: item,
        );
}

mixin ProductDropDownModel {
  String? get name;
}
