import 'package:flutter/material.dart';

class CitySelectDropdown extends StatefulWidget {
  CitySelectDropdown(
      {Key? key,
      this.selectedItems,
      required this.tittleText,
      required this.items,
      required this.onChanged})
      : super(key: key);

  List<String> items = ['Çaşdaşke', 'Celalke', 'Beyzake'];
  final String? selectedItems;
  final String tittleText;

  final void Function(String? model) onChanged;

  @override
  State<CitySelectDropdown> createState() => _CitySelectDropdownState();
}

class _CitySelectDropdownState extends State<CitySelectDropdown> {
  String? _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.selectedItems;
  }

  @override
  void _changeSelectItems(String? data) {
    // servisten çekildiği zaman model dönen degisikler
    setState(() {
      _selectedItems = data;
    });
    widget.onChanged(data);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        // decoration: OutlineLoginDecoraiton('Beyza', 'Vbt'),
        value: _selectedItems,
        onChanged: _changeSelectItems,
        hint: Text(widget.tittleText),
        items: widget.items.map((e) {
          return DropdownMenuItem(value: e, child: Text(e.toString()));
        }).toList());
  }
}
