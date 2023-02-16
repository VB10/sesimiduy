// ignore_for_file: prefer_final_fields

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/model/items.dart';

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
  late List<Items> needItems;
  List<Items> _selectedItems = [];

  final Iterable<Items> _filterItems = [];
  String latestQuery = '';
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
  void initState() {
    super.initState();
    needItems = widget.needItems;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            FlutterTagging<Items>(
              onChanged: () {
                widget.onSelected(_selectedItems);
              },
              initialItems: _selectedItems,
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  hintText: LocaleKeys.hintCategory.tr(),
                ),
              ),
              hideOnError: true,
              hideOnEmpty: true,
              findSuggestions: (String query) {
                return needItems
                    .toList()
                    .where(
                      (element) =>
                          element.name
                              ?.toLowerCase()
                              .withoutSpecialCharacters
                              ?.contains(
                                query.withoutSpecialCharacters ?? '',
                              ) ??
                          false,
                    )
                    .toList();
              },
              additionCallback: (p0) {
                return Items(name: p0);
              },
              onAdded: (item) => item,
              configureSuggestion: (item) {
                return SuggestionConfiguration(
                  title: Text(item.name ?? ''),
                  additionWidget: const Chip(
                    avatar: Icon(
                      Icons.add_circle,
                      color: Colors.white,
                    ),
                    label: Text('Add New Item'),
                  ),
                );
              },
              configureChip: (item) {
                return ChipConfiguration(
                  label: Text(item.name ?? ''),
                  backgroundColor: ColorsCustom.sambacus,
                  labelStyle: const TextStyle(color: ColorsCustom.white),
                  deleteIconColor: ColorsCustom.white,
                );
              },
            ),
            AnimatedPositioned(
              duration: context.durationLow,
              right: 0,
              child: AnimatedCrossFade(
                firstChild: IconButton(
                  onPressed: () {
                    _selectedItems.add(Items(name: latestQuery));

                    setState(() {
                      latestQuery = '';
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
                secondChild: const SizedBox(),
                crossFadeState: (_filterItems.isEmpty && latestQuery.isNotEmpty)
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: context.durationLow,
              ),
            )
          ],
        )
      ],
    );
  }

  Iterable<Items> _filterNeedItems(String query) {
    return needItems.where(
      (element) =>
          element.name?.toLowerCase().withoutSpecialCharacters?.contains(
                query.withoutSpecialCharacters ?? '',
              ) ??
          false,
    );
  }
}
