import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/core/enums/core_locale.dart';
import 'package:sesimiduy/features/current_map/view/current_map_view.dart';
import 'package:sesimiduy/features/login/service/help_upload_service.dart';
import 'package:sesimiduy/features/sub/request_help_view.dart';
import 'package:sesimiduy/product/dialog/completed_dialog.dart';
import 'package:sesimiduy/product/dialog/deliver_help_dialog.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/model/delivery_help_form.dart';
import 'package:sesimiduy/product/model/request_help_form.dart';
import 'package:sesimiduy/product/utility/constants/image_constants.dart';
import 'package:sesimiduy/product/utility/constants/social_media_links_constants.dart';
import 'package:sesimiduy/product/utility/constants/string_constants.dart';
import 'package:sesimiduy/product/utility/decorations/style/bold_outline_style.dart';
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
                ].map((e) => _ButtonResponsive(child: e)).toList(),
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
    );
  }
}

class _GoingHelpButton extends StatefulWidget {
  const _GoingHelpButton();

  @override
  State<_GoingHelpButton> createState() => _GoingHelpButtonState();
}

class _GoingHelpButtonState extends State<_GoingHelpButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: CustomButtonStyle.normal.copyWith(
        backgroundColor: MaterialStateProperty.all(
          ColorsCustom.sambacus,
        ),
      ),
      onPressed: onPressed,
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator(
                color: ColorsCustom.white,
              )
            : Text(
                LocaleKeys.login_goingHelp.tr().toUpperCase(),
                style: context.textTheme.titleLarge
                    ?.copyWith(color: ColorsCustom.white),
              ),
      ),
    );
  }

  void _changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> onPressed() async {
    if (isLoading) return;
    final request =
        await const DeliverHelpDialog().show<DeliveryHelpForm>(context);
    _changeLoading();
    if (request == null) {
      _changeLoading();
      return;
    }
    await HelpUploadService().createDeliveryCall(deliveryForm: request);
    _changeLoading();
  }
}

class _HelpWantedButton extends StatefulWidget {
  const _HelpWantedButton();

  @override
  State<_HelpWantedButton> createState() => _HelpWantedButtonState();
}

class _HelpWantedButtonState extends State<_HelpWantedButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: CustomButtonStyle.bold,
      onPressed: onPressed,
      child: FittedBox(
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: ColorsCustom.sambacus,
                )
              : Text(
                  LocaleKeys.login_wantHelp.tr().toUpperCase(),
                  style: context.textTheme.titleLarge,
                ),
        ),
      ),
    );
  }

  void _changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> onPressed() async {
    if (isLoading) return;
    _changeLoading();

    final response =
        await context.navigateToPage<RequestHelpForm>(const RequestHelpView());

    if (response == null) {
      _changeLoading();
      return;
    }
    final uploadService = HelpUploadService();
    await uploadService.createHelpCall(helpForm: response);
    _changeLoading();
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
