// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/features/login/service/help_upload_service.dart';
import 'package:sesimiduy/features/login/view/widget/going_help_button.dart';
import 'package:sesimiduy/features/sub/request_help_view.dart';
import 'package:sesimiduy/product/dialog/success_dialog.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/model/request_help_form.dart';
import 'package:sesimiduy/product/utility/decorations/style/bold_outline_style.dart';
import 'package:sesimiduy/product/utility/decorations/style/button_rectangle_border.dart';
import 'package:sesimiduy/product/utility/mixin/loading_state_mixin.dart';

class HelpWantedButton extends StatefulWidget {
  const HelpWantedButton({super.key});

  @override
  State<HelpWantedButton> createState() => _HelpWantedButtonState();
}

class _HelpWantedButtonState extends State<HelpWantedButton> with LoadingState {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ButtonHeightHelper(context).height,
      child: OutlinedButton(
        style: CustomButtonStyle.normal.copyWith(
          backgroundColor:
              const MaterialStatePropertyAll(ColorsCustom.imperilRead),
          shape: const MaterialStatePropertyAll(CustomRectangleBorder()),
        ),
        onPressed: onPressed,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: ColorsCustom.sambacus,
                )
              : FittedBox(
                  child: Text(
                    LocaleKeys.login_wantHelp.tr(),
                    style: context.textTheme.titleLarge?.copyWith(
                      color: ColorsCustom.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> onPressed() async {
    if (isLoading) return;
    changeLoading();

    final response =
        await context.navigateToPage<RequestHelpForm>(const RequestHelpView());

    if (response == null) {
      changeLoading();
      return;
    }
    final uploadService = HelpUploadService();
    await uploadService.createHelpCall(helpForm: response);
    unawaited(SuccessDialog(
      message: LocaleKeys.messages_success_helpRequest.tr(),
    ).show(context));
    changeLoading();
  }

  void showInSnackBar(String title, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        backgroundColor: ColorsCustom.sambacus,
        showCloseIcon: true,
        closeIconColor: Colors.white,
      ),
    );
  }
}
