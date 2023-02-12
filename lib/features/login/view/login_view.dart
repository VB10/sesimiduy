// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/core/enums/core_locale.dart';
import 'package:sesimiduy/features/login/view/widget/complete_buutton.dart';
import 'package:sesimiduy/features/login/view/widget/current_map_button.dart';
import 'package:sesimiduy/features/login/view/widget/going_help_button.dart';
import 'package:sesimiduy/features/login/view/widget/help_wanted_button.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/constants/image_constants.dart';
import 'package:sesimiduy/product/utility/constants/social_media_links_constants.dart';
import 'package:sesimiduy/product/utility/constants/string_constants.dart';
import 'package:sesimiduy/product/utility/maps/maps_manager.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/index.dart';
import 'package:sesimiduy/product/widget/builder/responsive_builder.dart';
import 'package:sesimiduy/product/widget/button/social_media_button.dart';
import 'package:sesimiduy/product/widget/dropdown/language_dropdown.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    MapsManager.checkPermission();
  }

  void openWeb(String value) {
    value.launchWebsite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const _Header(),
          const SizedBox(height: WidgetSizes.spacingXsMid),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const PagePadding.horizontalSymmetric() +
                    const PagePadding.onlyTopNormal(),
                child: Wrap(
                  runSpacing: WidgetSizes.spacingL,
                  spacing: WidgetSizes.spacingL,
                  children: const [
                    HelpWantedButton(),
                    GoingHelpButton(),
                    CurrentMaps(),
                    CompletedButton(),
                  ].map((e) => _ButtonResponsive(child: e)).toList(),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const PagePadding.all(),
                  child: Text(
                    LocaleKeys.login_description.tr(),
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodySmall
                        ?.copyWith(decoration: TextDecoration.underline),
                  ),
                ),
                _socialMediaButtons()
              ],
            ),
          )
        ],
      ),
    );
  }

  Row _socialMediaButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaButton(
          onTap: () => openWeb(SocialMediaLinksConstants.twitterUrl),
          icon: FontAwesomeIcons.twitter,
          title: StringConstants.twitter,
        ),
        SocialMediaButton(
          onTap: () => openWeb(SocialMediaLinksConstants.instagramUrl),
          icon: FontAwesomeIcons.instagram,
          title: StringConstants.instagram,
        ),
        SocialMediaButton(
          onTap: () => openWeb(SocialMediaLinksConstants.afadUrl),
          icon: FontAwesomeIcons.a,
          title: StringConstants.afad,
        ),
      ],
    );
  }
}

class _ButtonResponsive extends StatelessWidget {
  const _ButtonResponsive({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (windowSize) {
        return SizedBox(
          width: windowSize.isMobile != true
              ? MediaQuery.of(context).size.width / 3
              : MediaQuery.of(context).size.width,
          child: child,
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
        height: 300,
        child: Stack(
          children: [
            Positioned.fill(
              child: ColoredBox(
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
                  value: CoreLocale.fromLocale(context.locale),
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
