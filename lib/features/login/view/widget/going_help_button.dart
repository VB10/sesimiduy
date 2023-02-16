import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sesimiduy/features/login/service/help_upload_service.dart';
import 'package:sesimiduy/product/dialog/deliver_help_dialog.dart';
import 'package:sesimiduy/product/dialog/success_dialog.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/model/delivery_help_form.dart';
import 'package:sesimiduy/product/utility/decorations/style/bold_outline_style.dart';
import 'package:sesimiduy/product/utility/decorations/style/button_rectangle_border.dart';
import 'package:sesimiduy/product/utility/mixin/loading_state_mixin.dart';
import 'package:sesimiduy/product/utility/size/widget_size.dart';

class GoingHelpButton extends StatefulWidget {
  const GoingHelpButton({super.key});

  @override
  State<GoingHelpButton> createState() => _GoingHelpButtonState();
}

class _GoingHelpButtonState extends State<GoingHelpButton> with LoadingState {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: OutlinedButton(
        style: CustomButtonStyle.normal.copyWith(
          backgroundColor:
              const MaterialStatePropertyAll(ColorsCustom.royalPeacock),
          shape: const MaterialStatePropertyAll(CustomRectangleBorder()),
        ),
        onPressed: onPressed,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: ColorsCustom.white,
                )
              : FittedBox(
                  child: Text(
                    LocaleKeys.login_goingHelp.tr(),
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
    final response =
        await const DeliverHelpDialog().show<DeliveryHelpForm>(context);
    changeLoading();
    if (response == null) {
      changeLoading();
      return;
    }
    final result =
        await HelpUploadService().createDeliveryCall(deliveryForm: response);
    if (result && context.mounted) {
      await const SuccessDialog().show(context);
    }
    changeLoading();
  }
}

class ButtonHeightHelper {
  ButtonHeightHelper(this.context);

  final BuildContext context;
  double get height {
    return getValueForScreenType<double>(
      context: context,
      mobile: WidgetSizes.spacingXxlL12 / 2,
      tablet: WidgetSizes.spacingXxlL12,
      desktop: WidgetSizes.spacingXxlL12,
    );
  }
}
