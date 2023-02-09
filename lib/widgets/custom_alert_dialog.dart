import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomAlertDialog extends StatefulWidget {
  final BuildContext context;
  final Widget content;
  final String title;

  const CustomAlertDialog(
      {Key? key,
      required this.title,
      required this.context,
      required this.content})
      : super(key: key);

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title, style: context.textTheme.titleSmall),
          InkWell(
            onTap: () async {
              context.router.pop();
            },
            child: const Icon(Icons.close),
          ),
        ],
      ),
      content: widget.content,
    );
  }
}
