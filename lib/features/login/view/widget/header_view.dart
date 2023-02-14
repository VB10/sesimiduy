// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/core/enums/core_locale.dart';
import 'package:sesimiduy/product/generated/assets.gen.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/index.dart';
import 'package:sesimiduy/product/utility/size/widget_custom_size.dart';
import 'package:sesimiduy/product/widget/dropdown/language_dropdown.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: SizedBox(
        height: WidgetCustomSize.header.value,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned.fill(
              child: ColoredBox(
                color: ColorsCustom.sambacus,
                child: SafeArea(
                  child: Padding(
                    padding: const PagePadding.horizontalSymmetric(),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: LanguageDropDown(
                            value: CoreLocale.fromLocale(context.locale),
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            Assets.icons.icAppHighLogo.path,
                          ),
                        ),
                        const SizedBox(height: WidgetSizes.spacingXsMid),
                        Expanded(
                          child: Text(
                            LocaleKeys.login_info.tr(),
                            textAlign: TextAlign.center,
                            style: context.textTheme.titleLarge?.copyWith(
                              color: ColorsCustom.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: context.dynamicWidth(.3),
              child: const _ClipperTriangle(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClipperTriangle extends StatelessWidget {
  const _ClipperTriangle();

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 2,
      child: ClipPath(
        clipper: TriangleClipper(),
        child: SizedBox.square(
          dimension: IconSize.medium.value,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
