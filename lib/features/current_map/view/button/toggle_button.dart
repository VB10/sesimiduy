import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  final List<bool> _selectedOptions = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: _selectedOptions,
      onPressed: (int index) {
        setState(() {
          for (var i = 0; i < _selectedOptions.length; i++) {
            _selectedOptions[i] = i == index;
          }
        });
      },
      selectedColor: ColorsCustom.white,
      fillColor: ColorsCustom.sambacus,
      borderRadius: context.lowBorderRadius,
      children: const [
        Padding(
          padding: PagePadding.horizontalLowSymmetric(),
          child: Text('Talepler'),
        ),
        Padding(
          padding: PagePadding.horizontalLowSymmetric(),
          child: Text('Araçlar'),
        ),
      ],
    );
  }
}
