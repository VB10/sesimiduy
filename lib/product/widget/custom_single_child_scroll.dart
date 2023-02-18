import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomSingleChildScroll extends StatelessWidget {
  const CustomSingleChildScroll({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.keyboardPadding),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: child,
      ),
    );
  }
}
