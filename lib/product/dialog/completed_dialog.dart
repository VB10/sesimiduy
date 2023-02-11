import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/extension/string_lang_extension.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';
import 'package:sesimiduy/product/utility/constants/string_constants.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/widget_size.dart';
import 'package:sesimiduy/product/utility/validator/validator_items.dart';
import 'package:sesimiduy/product/widget/builder/responsive_builder.dart';
import 'package:sesimiduy/product/widget/button/active_button.dart';
import 'package:sesimiduy/product/widget/checkbox/kvkk_checkbox.dart';
import 'package:sesimiduy/product/widget/spacer/dynamic_vertical_spacer.dart';
import 'package:sesimiduy/product/widget/text_field/labeled_product_textfield.dart';

class CompletedDialog extends StatefulWidget {
  const CompletedDialog({super.key});

  @override
  State<CompletedDialog> createState() => _CompletedDialogState();

  Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => this,
    );
  }
}

class _CompletedDialogState extends State<CompletedDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const PagePadding.all(),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: ResponsiveBuilder(
          builder: (windowSize) {
            return SizedBox(
              width: windowSize.isMobile ? null : context.dynamicWidth(0.3),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _Header(),
                    const _CustomDivider(),
                    const VerticalSpace.standard(),
                    const _NameTextField(),
                    const VerticalSpace.standard(),
                    const _PhoneField(),
                    const VerticalSpace.standard(),
                    const _PlateTextField(),
                    const VerticalSpace.standard(),
                    _kvkkCheckBox(),
                    const VerticalSpace.standard(),
                    _ActionButton(
                      formKey: _formKey,
                      isAccepted: isAccepted,
                    ),
                    const VerticalSpace.small(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  KVKKCheckBox _kvkkCheckBox() {
    return KVKKCheckBox(
      isAccepted: isAccepted,
      onAccepted: (value) {
        setState(() {
          isAccepted = value;
        });
      },
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
            LocaleKeys.delivered.locale,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              context.navigation.pop();
            },
            icon: const Icon(Icons.close),
            iconSize: WidgetSizes.spacingXxl,
          )
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.formKey,
    required this.isAccepted,
  });

  final GlobalKey<FormState> formKey;
  final bool isAccepted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: ActiveButton(
        label: LocaleKeys.deliver.locale,
        onPressed: () {
          if ((formKey.currentState?.validate() ?? false) && isAccepted) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        hintText: StringConstants.phoneHint,
        formatters: [InputFormatter.instance.phoneFormatter],
        labelText: LocaleKeys.phoneNumber.locale,
        validator: (text) => ValidatorItems(text).validatePhoneNumber,
      ),
    );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        hintText: LocaleKeys.nameAndSurname.locale,
        labelText: LocaleKeys.nameAndSurname.locale,
        validator: (value) => ValidatorItems(value).validateFullName,
      ),
    );
  }
}

class _PlateTextField extends StatelessWidget {
  const _PlateTextField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: LabeledProductTextField(
        hintText: LocaleKeys.plate.locale,
        labelText: LocaleKeys.plate.locale,
        validator: (value) => ValidatorItems(value).validatePlate,
      ),
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ColorsCustom.lightGray,
      thickness: AppConstants.kOne.toDouble(),
      height: AppConstants.kZero.toDouble(),
    );
  }
}
