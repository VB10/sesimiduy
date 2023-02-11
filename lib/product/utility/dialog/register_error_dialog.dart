import 'package:flutter/material.dart';
import 'package:sesimiduy/product/extension/string_lang_extension.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/utility/dialog/display_dialog_mixin.dart';

class RegisterErrorDialog with DisplayDialogMixin {
  RegisterErrorDialog({
    required this.context,
    String? title,
  }) : title = title ?? LocaleKeys.dialog_errorTitle.locale;

  @override
  final BuildContext context;

  @override
  final String title;

  @override
  Widget get icon {
    return const CircleAvatar(
      backgroundColor: Colors.red,
      child: Icon(Icons.clear, color: Colors.white),
    );
  }
}
