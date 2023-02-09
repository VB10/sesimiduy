import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/enum/icon_size.dart';
import 'package:sesimiduy/product/enum/widget_size.dart';

import 'package:sesimiduy/product/items/colors_custom.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // CustomColor
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _Header(),
            Column(
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(),
                  onPressed: () {},
                  child: Center(
                    child: Text(
                      'YARDIM İSTİYORUM',
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: WidgetSizes.spacingXxlL14,
      child: Stack(
        children: [
          Container(
            color: ColorsCustom.sambacus,
          ),
          Positioned(
            bottom: 0,
            left: context.dynamicWidth(.3),
            child: const _ClipperTriangle(),
          )
        ],
      ),
    );
  }
}

class _ClipperTriangle extends StatelessWidget {
  const _ClipperTriangle();

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 2,
      child: ClipPath(
        clipper: TriangleClipper(),
        child: SizedBox.square(
          dimension: IconSize.medium.value,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
