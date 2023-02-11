import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class AppBuilder {
  AppBuilder._();

  static Widget build(BuildContext context, Widget? child) {
    return ResponsiveWrapper.builder(
      child,
      breakpoints: [
        const ResponsiveBreakpoint.resize(480, name: MOBILE),
        const ResponsiveBreakpoint.autoScale(800, name: TABLET),
        const ResponsiveBreakpoint.resize(
          1000,
          name: DESKTOP,
        ),
      ],
    );
  }
}
