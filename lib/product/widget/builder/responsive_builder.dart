import 'package:flutter/material.dart';

enum WindowsSize {
  mobile,
  tablet,
  desktop;

  bool get isMobile => this == WindowsSize.mobile;
  bool get isTablet => this == WindowsSize.tablet;
  bool get isDesktop => this == WindowsSize.desktop;
}

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    this.mobileBreakpoint = 500,
    this.tabletBreakpoint = 800,
    this.desktopBreakpoint = 1200,
    required this.builder,
  });

  final double mobileBreakpoint;
  final double tabletBreakpoint;
  final double desktopBreakpoint;

  final Widget Function(WindowsSize) builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= mobileBreakpoint) {
          return builder(WindowsSize.mobile);
        } else if (constraints.maxWidth > mobileBreakpoint &&
            constraints.maxWidth <= tabletBreakpoint) {
          return builder(WindowsSize.tablet);
        } else if (constraints.maxWidth > tabletBreakpoint) {
          return builder(WindowsSize.desktop);
        }
        return builder(WindowsSize.desktop);
      },
    );
  }
}
