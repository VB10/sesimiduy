import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../utility/size/widget_size.dart';

/// Returns a [SizedBox] with the given [width].
class HorizontalSpace extends SizedBox {
  final double width;
  const HorizontalSpace({Key? key, required this.width}) : super(key: key);

  /// Returns a [SizedBox] with the 2px width.
  const HorizontalSpace.xxxSmall({Key? key})
      : this(key: key, width: WidgetSizes.spacingXSS);

  /// Returns a [SizedBox] with the 8px width.
  const HorizontalSpace.xxSmall({Key? key})
      : this(key: key, width: WidgetSizes.spacingXs);
  /// Returns a [SizedBox] with the 12px width.
  const HorizontalSpace.xSmall({Key? key})
      : this(key: key, width: WidgetSizes.spacingS);

  /// Returns a [SizedBox] with the 16px width.
  const HorizontalSpace.standard({Key? key})
      : this(key: key, width: WidgetSizes.spacingM);

  /// Returns a [SizedBox] with the 20px width.
  const HorizontalSpace.small({Key? key})
      : this(key: key, width: WidgetSizes.spacingL);

  /// Returns a [SizedBox] with the 40px width.
  const HorizontalSpace.medium({Key? key})
      : this(key: key, width: WidgetSizes.spacingXxl4);

  /// Returns a [SizedBox] with the 60px width.
  const HorizontalSpace.large({Key? key})
      : this(key: key, width: WidgetSizes.spacingXxl8);

  /// Returns a [SizedBox] with the 100px width.
  const HorizontalSpace.xLarge({Key? key})
      : this(key: key, width: WidgetSizes.spacingXxl12);

  /// Returns a [SizedBox] with the given [width] percentage of the screen width.
  HorizontalSpace.withPercentage({
    Key? key,
    required double percentage,
    required BuildContext context,
  }) : this(
          key: key,
          width: (percentage / 100) * context.width,
        );
}
