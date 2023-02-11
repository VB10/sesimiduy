import 'package:flutter/material.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/model/items.dart';
import 'package:textfield_tags/textfield_tags.dart';

class ItemsTextField extends StatefulWidget {
  const ItemsTextField({
    required this.needItems,
    required this.onSelected,
    super.key,
  });
  final List<Items> needItems;
  final ValueChanged<List<Items>> onSelected;
  @override
  State<ItemsTextField> createState() => _ItemsTextFieldState();
}

class _ItemsTextFieldState extends State<ItemsTextField> {
  late TextfieldTagsController _controller;
  late List<Items> needItems;
  final List<Items> _selectedLanguages = [];

  @override
  void didUpdateWidget(covariant ItemsTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.needItems != oldWidget.needItems) {
      setState(() {
        needItems = widget.needItems;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextfieldTagsController();
    needItems = widget.needItems;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutterTagging<Items>(
          onChanged: () {
            widget.onSelected(_selectedLanguages);
          },
          initialItems: _selectedLanguages,
          textFieldConfiguration: const TextFieldConfiguration(
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              hintText: 'İhtiyaçları seçiniz',
            ),
          ),
          findSuggestions: (String query) {
            return needItems;
          },
          onAdded: (language) => language,
          configureSuggestion: (lang) {
            return SuggestionConfiguration(
              title: Text(lang.name ?? ''),
            );
          },
          configureChip: (lang) {
            return ChipConfiguration(
              label: Text(lang.name ?? ''),
              backgroundColor: ColorsCustom.sambacus,
              labelStyle: const TextStyle(color: ColorsCustom.white),
              deleteIconColor: ColorsCustom.white,
            );
          },
        )
      ],
    );
  }
}
