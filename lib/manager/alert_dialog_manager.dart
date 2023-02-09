import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_alert_dialog.dart';

class AlertDialogManager {
  static AlertDialogManager? _instance;

  static AlertDialogManager get instance {
    return _instance ??= AlertDialogManager._init();
  }

  late AlertDialog alertDialog;

  AlertDialogManager._init() {
    alertDialog = const AlertDialog();
  }

  void showForm(BuildContext context, String title, Widget body) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          context: context,
          title: title,
          content: body,
        );
      },
    );
  }
}
