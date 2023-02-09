import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/widget/text_field/labeled_product_textfield.dart';

class RequestHelpDialog extends StatelessWidget {
  const RequestHelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const PagePadding.all(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          context.emptySizedHeightBoxLow,
          const _Header(),
          const _CustomDivider(),
          context.emptySizedHeightBoxLow3x,
          const Padding(
            padding: PagePadding.horizontalSymmetric(),
            child: Text('Yardıma ihtiyacı olan kişinin'),
          ),
          context.emptySizedHeightBoxLow3x,
          const Padding(
            padding: PagePadding.horizontalSymmetric(),
            child: LabeledProductTextField(labelText: 'Adı Soyadı'),
          ),
          context.emptySizedHeightBoxLow3x,
          const Padding(
            padding: PagePadding.horizontalSymmetric(),
            child: LabeledProductTextField(labelText: 'Telefon Numarası'),
          ),
          context.emptySizedHeightBoxLow3x,
          const Padding(
            padding: PagePadding.horizontalSymmetric(),
            child: LabeledProductTextField(labelText: 'Adresi'),
          ),
        ],
      ),
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: AppConstants.kZero.toDouble(),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.all(),
      child: Row(
        children: [
          Text(
            'YARDIM İSTİYORUM',
            style: context.textTheme.headlineSmall,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              context.navigation.pop();
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
    );
  }
}

extension RequestHelpDialogExtension on RequestHelpDialog {
  Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return this;
      },
    );
  }
}
