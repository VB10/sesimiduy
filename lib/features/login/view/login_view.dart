// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sesimiduy/features/login/view/widget/complete_button.dart';
import 'package:sesimiduy/features/login/view/widget/current_map_button.dart';
import 'package:sesimiduy/features/login/view/widget/going_help_button.dart';
import 'package:sesimiduy/features/login/view/widget/header_view.dart';
import 'package:sesimiduy/features/login/view/widget/help_wanted_button.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/index.dart';
import 'package:sesimiduy/product/utility/state/app_provider.dart';
import 'package:sesimiduy/product/widget/wrap/social_media_buttons.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(AppProvider.provider.notifier).init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          LoginHeader(),
          SizedBox(height: WidgetSizes.spacingXsMid),
          Expanded(
            child: _Body(),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const PagePadding.horizontalSymmetric(),
        child: Column(
          children: [
            Wrap(
              runSpacing: WidgetSizes.spacingL,
              spacing: WidgetSizes.spacingL,
              children: const [
                HelpWantedButton(),
                GoingHelpButton(),
                CurrentMaps(),
                CompletedButton(),
              ].map((e) => _ButtonResponsive(child: e)).toList(),
            ),
            SafeArea(
              top: false,
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
                  const SocialMediaButtons()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ButtonResponsive extends StatelessWidget {
  const _ButtonResponsive({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: getValueForScreenType<double>(
      //   context: context,
      //   mobile: context.height / 13,
      //   desktop: context.height / 8,
      // ),
      width: getValueForScreenType<double>(
        context: context,
        mobile: context.width,
        tablet: context.width / 3,
        desktop: context.width / 3,
      ),
      child: child,
    );
  }
}
