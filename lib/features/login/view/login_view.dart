import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/constants/image_constants.dart';
import 'package:sesimiduy/product/utility/decorations/style/bold_outline_style.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/index.dart';

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
    return ElevatedButton(
      style: CustomButtonStyle.normal.copyWith(
        backgroundColor: MaterialStateProperty.all(
          ColorsCustom.braziliante,
        ),
      ),
      onPressed: () {},
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
    );
  }
}

class _CurrentMaps extends StatelessWidget {
  const _CurrentMaps();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: CustomButtonStyle.normal.copyWith(
        backgroundColor: MaterialStateProperty.all(
          ColorsCustom.endless,
        ),
      ),
      onPressed: () {},
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
    );
  }
}

class _GoingHelpButton extends StatelessWidget {
  const _GoingHelpButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: CustomButtonStyle.normal.copyWith(
        backgroundColor: MaterialStateProperty.all(
          ColorsCustom.sambacus,
        ),
      ),
      onPressed: () {},
      child: Center(
        child: Text(
          LocaleKeys.login_goingHelp.tr().toUpperCase(),
          style:
              context.textTheme.titleLarge?.copyWith(color: ColorsCustom.white),
        ),
      ),
    );
  }
}

class _HelpWantedButton extends StatelessWidget {
  const _HelpWantedButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: CustomButtonStyle.bold,
      onPressed: () {},
      child: Center(
        child: Text(
          LocaleKeys.login_wantHelp.tr().toUpperCase(),
          style: context.textTheme.titleLarge,
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: WidgetSizes.spacingXxlL14,
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
          )
        ],
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
