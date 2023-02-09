import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:sesimiduy/product/utility/dialog/display_dialog_mixin.dart';

import 'package:sesimiduy/product/init/language/locale_keys.g.dart';

class RegisterSuccessDialog with DisplayDialogMixin {
  RegisterSuccessDialog({
    required this.context,
    String? title,
  }) : title = title ?? LocaleKeys.dialog_successTitle.tr();

  @override
  final BuildContext context;

  @override
  final String title;

  @override
  Widget get icon {
    return const CircleAvatar(
      backgroundColor: Colors.green,
      child: Icon(Icons.done, color: Colors.white),
    );
  }
}
