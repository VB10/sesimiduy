import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';

import 'package:sesimiduy/product/items/colors_custom.dart';

class PermissionDialog {
  const PermissionDialog(this.context);

  final BuildContext context;
  Future<void> show() async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.warning_amber_outlined,
          color: ColorsCustom.endless,
        ),
        title: Text(LocaleKeys.dialog_permissionTitle.tr()),
        content: Text(
          LocaleKeys.dialog_permissionDescription.tr(),
        ),
      ),
    );
  }
}
