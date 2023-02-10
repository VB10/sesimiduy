import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';
import 'package:sesimiduy/product/utility/constants/string_constants.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/size/widget_size.dart';
import 'package:sesimiduy/product/utility/validator/validator_items.dart';
import 'package:sesimiduy/product/widget/builder/responsive_builder.dart';
import 'package:sesimiduy/product/widget/button/active_button.dart';
import 'package:sesimiduy/product/widget/product_checkbox.dart';
import 'package:sesimiduy/product/widget/spacer/dynamic_vertical_spacer.dart';
import 'package:sesimiduy/product/widget/text_field/labeled_product_textfield.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
                    const _KvkkCheckBox(),
                    _ActionButton(formKey: _formKey),
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
}

class _KvkkCheckBox extends StatelessWidget {
  const _KvkkCheckBox();

  @override
  Widget build(BuildContext context) {
    const kvkkUrl =
        'https://kvkk.gov.tr/yayinlar/K%C4%B0%C5%9E%C4%B0SEL%20VER%C4%B0LER%C4%B0N%20KORUNMASI%20KANUNU%20VE%20UYGULAMASI.pdf';
    return ProductCheckbox(
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: LocaleKeys.kvkk.tr(),
              style: const TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _navigate(context, kvkkUrl);
                },
            ),
            TextSpan(
              text: LocaleKeys.kvkkReadApproved.tr(),
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      onSaved: (value) {},
      validator: (value) {
        return value != null && value == true
            ? null
            : LocaleKeys.validation_kvkk.tr();
      },
    );
  }

  void _navigate(BuildContext context, String kvkkUrl) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: SfPdfViewer.network(kvkkUrl),
          );
        },
      ),
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
            LocaleKeys.delivered.tr(),
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
  const _ActionButton({required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: ActiveButton(
        label: LocaleKeys.deliver.tr(),
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
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
        labelText: LocaleKeys.phoneNumber.tr(),
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
        hintText: LocaleKeys.nameAndSurname.tr(),
        labelText: LocaleKeys.nameAndSurname.tr(),
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
        hintText: LocaleKeys.plate.tr(),
        labelText: LocaleKeys.plate.tr(),
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
