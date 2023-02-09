import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/utility/decorations/empty_box.dart';

mixin DisplayDialogMixin {
  BuildContext get context;
  Widget get icon;
  String get title;

  Future<T?> showAlertDialog<T>({
    required String content,
    bool isDismissible = true,
    bool isUseRootNavigator = true,
    VoidCallback? onAfterPop,
  }) async {
    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissible,
      useRootNavigator: isUseRootNavigator,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => Future.value(isDismissible),
          child: AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding: const EdgeInsets.all(20).copyWith(top: 4),
            title: _buildTitle(context, onAfterPop),
            content: _buildContent(context, content),
          ),
        );
      },
    );
  }

  Column _buildContent(BuildContext context, String content) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const EmptyBox.middleHeight(),
        Text(
          title,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const EmptyBox.smallHeight(),
        Text(
          content,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Row _buildTitle(BuildContext context, VoidCallback? onAfterPop) {
    return Row(
      children: [
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            context.pop();
            onAfterPop?.call();
          },
        ),
      ],
    );
  }
}
