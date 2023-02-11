import 'package:flutter/material.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';

class FilterDropDown extends StatefulWidget {
  const FilterDropDown({super.key});

  @override
  State<FilterDropDown> createState() => _FilterDropDownState();
}

class _FilterDropDownState extends State<FilterDropDown> {
  final filterItems = ['item1', 'item2', 'item3', 'item4'];
  String selectedItem = '';
  final PageController controller = PageController();

  @override
  void initState() {
    selectedItem = filterItems.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        dropdownColor: ColorsCustom.sambacus,
        items: filterItems
            .map(
              (e) => DropdownMenuItem(
                  value: e,
                  onTap: () {},
                  child: Text(
                    e,
                    style: const TextStyle(color: ColorsCustom.white),
                  )),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            if (value != null) selectedItem = value;
          });
        },
        value: selectedItem,
      ),
    );
  }
}
