import 'package:flutter/material.dart';

import 'package:sesimiduy/product/items/colors_custom.dart';

class PermissionDialog {
  const PermissionDialog(this.context);

  final BuildContext context;
  Future<void> show() async {
    await showDialog<void>(
      context: context,
      builder: (context) => const AlertDialog(
        icon: Icon(
          Icons.warning_amber_outlined,
          color: ColorsCustom.endless,
        ),
        title: Text('Please allow location access'),
        content: Text(
          'Please allow location access to use this feature',
        ),
      ),
    );
  }
}
