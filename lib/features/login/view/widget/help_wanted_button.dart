import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/features/login/service/help_upload_service.dart';
import 'package:sesimiduy/features/sub/request_help_view.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/model/request_help_form.dart';
import 'package:sesimiduy/product/utility/decorations/style/bold_outline_style.dart';
import 'package:sesimiduy/product/utility/decorations/style/button_rectangle_border.dart';
import 'package:sesimiduy/product/utility/mixin/loading_state_mixin.dart';
import 'package:sesimiduy/product/utility/size/widget_size.dart';
import 'package:sesimiduy/product/widget/text/button_large_text.dart';

class HelpWantedButton extends StatefulWidget {
  const HelpWantedButton({super.key});

  @override
  State<HelpWantedButton> createState() => _HelpWantedButtonState();
}

class _HelpWantedButtonState extends State<HelpWantedButton> with LoadingState {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: WidgetSizes.spacingXxlL12,
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
              : ButtonLargeText(
                  title: LocaleKeys.login_wantHelp.tr(),
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
