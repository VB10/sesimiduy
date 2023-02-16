import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/index.dart';
import 'package:sesimiduy/product/widget/builder/responsive_builder.dart';
import 'package:sesimiduy/product/widget/spacer/dynamic_horizontal_spacer.dart';
import 'package:sesimiduy/product/widget/spacer/dynamic_vertical_spacer.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWindowBuilder(
      builder: (windowSize) => Dialog(
        child: Padding(
          padding: const PagePadding.all(),
          child: Flex(
            direction: windowSize.isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: windowSize.isMobile
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const _Leading(),
              if (windowSize.isMobile)
                const VerticalSpace.standard()
              else
                const HorizontalSpace.standard(),
              const TextSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWindowBuilder(
      builder: (windowSize) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: windowSize.isMobile
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.dialog_successTitle.tr(),
              style: context.textTheme.titleLarge,
            ),
            const VerticalSpace.standard(),
            Text(
              LocaleKeys.dialog_successContent.tr(),
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w400,
              ),
              textAlign:
                  windowSize.isMobile ? TextAlign.center : TextAlign.start,
            ),
          ],
        );
      },
    );
  }
}

class _Leading extends StatelessWidget {
  const _Leading();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ColorsCustom.braziliante,
      ),
      child: Icon(
        Icons.check,
        size: kIsWeb ? IconSize.xxLarge.value : IconSize.xLarge.value,
        color: ColorsCustom.white,
      ),
    );
  }
}

extension SuccessDialogExtension on SuccessDialog {
  Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => this,
    );
  }
}
