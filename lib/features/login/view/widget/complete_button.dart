import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sesimiduy/product/dialog/completed_dialog.dart';
import 'package:sesimiduy/product/dialog/success_dialog.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/model/complete_package.dart';
import 'package:sesimiduy/product/utility/decorations/style/bold_outline_style.dart';
import 'package:sesimiduy/product/utility/firebase/index.dart';
import 'package:sesimiduy/product/utility/mixin/app_provider_mixin.dart';
import 'package:sesimiduy/product/utility/mixin/loading_state_mixin.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/widget/padding/padding_normal_button.dart';
import 'package:sesimiduy/product/widget/text/button_normal_text.dart';

class CompletedButton extends ConsumerStatefulWidget {
  const CompletedButton({super.key});

  @override
  ConsumerState<CompletedButton> createState() => _CompletedButtonState();
}

class _CompletedButtonState extends ConsumerState<CompletedButton>
    with LoadingState, AppProviderMixin {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: CustomButtonStyle.bold.copyWith(
        backgroundColor: MaterialStateProperty.all(
          ColorsCustom.white,
        ),
      ),
      onPressed: () async {
        if (isLoading) return;
        changeLoading();
        final response = await showDialog<CompletePackage?>(
          context: context,
          builder: (context) => const CompletedDialog(),
        );

        if (response != null) {
          await appProvider.firebaseService.set<CompletePackage>(
            model: response,
            path: CollectionEnums.completeArrived,
          );

          if (context.mounted) {
            await SuccessDialog(
              message: LocaleKeys.messages_success_delivered.tr(),
            ).show(context);
          }
        }
        changeLoading();
      },
      child: PaddingNormalButton(
        child: isLoading
            ? const CircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.circleCheck,
                    color: ColorsCustom.sambacus,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const PagePadding.horizontalLowSymmetric(),
                      child: ButtonNormalText(
                        title: LocaleKeys.login_arrived.tr().toUpperCase(),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
