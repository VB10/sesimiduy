import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/core/enums/core_locale.dart';
import 'package:sesimiduy/features/current_map/view/current_map_view.dart';
import 'package:sesimiduy/product/dialog/deliver_help_dialog.dart';
import 'package:sesimiduy/product/dialog/request_help_dialog.dart';
import 'package:sesimiduy/product/dialog/completed_dialog.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/constants/image_constants.dart';
import 'package:sesimiduy/product/utility/decorations/style/bold_outline_style.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/index.dart';
import 'package:sesimiduy/product/widget/builder/responsive_builder.dart';
import 'package:sesimiduy/product/widget/dropdown/language_dropdown.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const _Header(),
          const SizedBox(height: WidgetSizes.spacingXsMid),
          Expanded(
            child: Padding(
              padding: const PagePadding.horizontalSymmetric() +
                  const PagePadding.onlyTopNormal(),
              child: Wrap(
                runSpacing: WidgetSizes.spacingL,
                spacing: WidgetSizes.spacingL,
                children: const [
                  _HelpWantedButton(),
                  _GoingHelpButton(),
                  _CurrentMaps(),
                  _CompletedButton(),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const PagePadding.all(),
              child: Text(
                LocaleKeys.login_description.tr(),
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall
                    ?.copyWith(decoration: TextDecoration.underline),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _CompletedButton extends StatelessWidget {
  const _CompletedButton();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (windowsSize) {
        return SizedBox(
          width: windowsSize.isMobile
              ? double.infinity
              : context.dynamicWidth(0.4),
          child: ElevatedButton(
            style: CustomButtonStyle.normal.copyWith(
              backgroundColor: MaterialStateProperty.all(
                ColorsCustom.braziliante,
              ),
            ),
            onPressed: () {
              const CompletedDialog().show(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(FontAwesomeIcons.circleCheck),
                Padding(
                  padding: const PagePadding.onlyLeftLow(),
                  child: Text(
                    LocaleKeys.login_arrived.tr().toUpperCase(),
                    style: context.textTheme.titleLarge
                        ?.copyWith(color: ColorsCustom.white),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CurrentMaps extends StatelessWidget {
  const _CurrentMaps();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (windowSize) {
        return SizedBox(
          width:
              windowSize.isMobile ? double.infinity : context.dynamicWidth(0.4),
          child: ElevatedButton(
            style: CustomButtonStyle.normal.copyWith(
              backgroundColor: MaterialStateProperty.all(
                ColorsCustom.endless,
              ),
            ),
            onPressed: () {
              context.navigateToPage<void>(const CurrentMapView());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(FontAwesomeIcons.earthAfrica),
                Padding(
                  padding: const PagePadding.onlyLeftLow(),
                  child: Text(
                    LocaleKeys.login_currentMap.tr().toUpperCase(),
                    style: context.textTheme.titleLarge
                        ?.copyWith(color: ColorsCustom.white),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GoingHelpButton extends StatelessWidget {
  const _GoingHelpButton();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (windowSize) {
        return SizedBox(
          width:
              windowSize.isMobile ? double.infinity : context.dynamicWidth(.4),
          child: ElevatedButton(
            style: CustomButtonStyle.normal.copyWith(
              backgroundColor: MaterialStateProperty.all(
                ColorsCustom.sambacus,
              ),
            ),
            onPressed: () {
              const DeliverHelpDialog().show(context);
            },
            child: Center(
              child: Text(
                LocaleKeys.login_goingHelp.tr().toUpperCase(),
                style: context.textTheme.titleLarge
                    ?.copyWith(color: ColorsCustom.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HelpWantedButton extends StatelessWidget {
  const _HelpWantedButton();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (windowSize) {
        return SizedBox(
          width:
              windowSize.isMobile ? double.infinity : context.dynamicWidth(.4),
          child: OutlinedButton(
            style: CustomButtonStyle.bold,
            onPressed: () {
              RequestHelpDialog().show(context);
            },
            child: Center(
              child: FittedBox(
                child: Text(
                  LocaleKeys.login_wantHelp.tr().toUpperCase(),
                  style: context.textTheme.titleLarge,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: SizedBox(
        height: kIsWeb ? context.dynamicHeight(.5) : WidgetSizes.spacingXxlL14,
        child: Stack(
          children: [
            ColoredBox(
              color: ColorsCustom.sambacus,
              child: Padding(
                padding: const PagePadding.horizontalSymmetric() +
                    const PagePadding.onlyTopNormal(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageConstants.logo,
                      height: IconSize.large.value,
                    ),
                    const SizedBox(height: WidgetSizes.spacingXsMid),
                    Text(
                      LocaleKeys.login_info.tr(),
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleLarge?.copyWith(
                        color: ColorsCustom.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: context.dynamicWidth(.3),
              child: const _ClipperTriangle(),
            ),
            Positioned(
              right: 0,
              child: SafeArea(
                child: LanguageDropDown(
                  value: CoreLocale.fromLocale(context.locale).changeCrossFlag,
                ),
              ),
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

extension _FlagHelper on CoreLocale {
  CoreLocale get changeCrossFlag {
    switch (this) {
      case CoreLocale.en:
        return CoreLocale.tr;
      case CoreLocale.tr:
        return CoreLocale.en;
    }
  }
}
