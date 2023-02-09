import 'package:flutter/material.dart';

class ProductComboBox<T extends ProductDropDownModel> extends StatelessWidget {
  const ProductComboBox({
    required this.items,
    super.key,
  });
  final List<T> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      items: items.map((e) => _ProductDropdownItem(item: e)).toList(),
      onChanged: (_) {},
    );
  }
}

class _ProductDropdownItem<T extends ProductDropDownModel> extends DropdownMenuItem<T> {
  _ProductDropdownItem({required T item}) : super(child: Text(item.name));
}

mixin ProductDropDownModel {
  String get name;
}
