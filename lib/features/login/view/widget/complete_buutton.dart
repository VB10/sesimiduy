import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sesimiduy/product/dialog/completed_dialog.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/decorations/style/bold_outline_style.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/widget/padding/padding_normal_button.dart';
import 'package:sesimiduy/product/widget/text/button_normal_text.dart';

class CompletedButton extends StatelessWidget {
  const CompletedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: CustomButtonStyle.bold.copyWith(
        backgroundColor: MaterialStateProperty.all(
          ColorsCustom.white,
        ),
      ),
      onPressed: () {
        const CompletedDialog().show(context);
      },
      child: PaddingNormalButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.circleCheck,
              color: ColorsCustom.sambacus,
            ),
            Flexible(
              child: Padding(
                padding: const PagePadding.onlyLeftLow(),
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
