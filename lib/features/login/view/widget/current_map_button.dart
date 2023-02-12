// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/features/current_map/view/current_map_view.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/decorations/style/bold_outline_style.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';

class CurrentMaps extends StatelessWidget {
  const CurrentMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: CustomButtonStyle.bold.copyWith(
        backgroundColor: MaterialStateProperty.all(
          ColorsCustom.white,
        ),
      ),
      onPressed: () {
        context.navigateToPage<void>(const CurrentMapView());
      },
      child: Padding(
        padding: const PagePadding.all(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.earthAfrica,
              color: ColorsCustom.sambacus,
            ),
            Flexible(
              child: Padding(
                padding: const PagePadding.onlyLeftLow(),
                child: Text(
                  LocaleKeys.login_currentMap.tr().toUpperCase(),
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
