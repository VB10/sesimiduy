import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';

class PaddingNormalButton extends StatelessWidget {
  const PaddingNormalButton({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getValueForScreenType<EdgeInsets>(
        context: context,
        mobile: EdgeInsets.zero,
        tablet: const PagePadding.all(),
        desktop: const PagePadding.all(),
      ),
      child: child,
    );
  }
}
