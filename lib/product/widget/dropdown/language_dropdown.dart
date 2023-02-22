import 'package:dash_flags/dash_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/core/enums/core_locale.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/mixin/loading_state_mixin.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/icon_size.dart';

class LanguageDropDown extends StatefulWidget {
  const LanguageDropDown({super.key, this.value});
  final CoreLocale? value;

  @override
  State<LanguageDropDown> createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> with LoadingState {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<CoreLocale>(
        selectedItemBuilder: (_) {
          return CoreLocale.values
              .map(
                (e) => _FlagText(item: e, isOpened: false),
              )
              .toList();
        },
        items: CoreLocale.values
            .map(
              (e) => DropdownMenuItem(
                value: e,
                onTap: () async {
                  await context.setLocale(e.locale);
                  final engine = WidgetsFlutterBinding.ensureInitialized();
                  await engine.performReassemble();
                },
                child: _FlagText(item: e, isOpened: true),
              ),
            )
            .toList(),
        onChanged: (value) {},
        value: widget.value,
      ),
    );
  }
}

class _FlagText extends StatelessWidget {
  const _FlagText({required this.item, required this.isOpened});
  final bool isOpened;
  final CoreLocale item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CountryFlag(
          country: item.flag,
          height: IconSize.smallX.value,
        ),
        Padding(
          padding: const PagePadding.horizontalNormalSymmetric(),
          child: Text(
            item.name.tr().toUpperCase(),
            style: context.textTheme.titleLarge?.copyWith(
              color: isOpened ? ColorsCustom.sambacus : ColorsCustom.white,
            ),
          ),
        ),
      ],
    );
  }
}
