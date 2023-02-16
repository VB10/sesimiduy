import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/widget/checkbox/product_checkbox.dart';

class InfoCheckBox extends StatelessWidget {
  const InfoCheckBox(this.autovalidateMode, {super.key});
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return ProductCheckbox(
      autovalidateMode: autovalidateMode,
      title: Text(LocaleKeys.confirmationText.tr()),
      onSaved: (value) {},
      validator: (value) {
        return value != null && value == true
            ? null
            : LocaleKeys.validation_confirmationText.tr();
      },
    );
  }
}
