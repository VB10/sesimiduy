import 'package:dash_flags/dash_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:sesimiduy/core/enums/core_locale.dart';

import 'package:sesimiduy/product/utility/size/icon_size.dart';

class LanguageDropDown extends StatelessWidget {
  const LanguageDropDown({super.key, this.value});
  final CoreLocale? value;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<CoreLocale>(
        items: CoreLocale.values
            .map(
              (e) => DropdownMenuItem(
                value: e,
                onTap: () {
                  context.setLocale(e.locale);
                },
                child: CountryFlag(
                  country: e.flag,
                  height: IconSize.smallX.value,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {},
        value: value,
      ),
    );
  }
}
