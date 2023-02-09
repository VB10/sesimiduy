import 'package:flutter/material.dart';

import 'package:sesimiduy/product/utility/size/widget_size.dart';

@immutable
class PagePadding extends EdgeInsets {
  const PagePadding.defaultPadding()
      : super.symmetric(
          horizontal: WidgetSizes.spacingM,
        );
  const PagePadding.horizontalSymmetric() : super.symmetric(horizontal: WidgetSizes.spacingL);
  const PagePadding.horizontal18Symmetric()
      : super.symmetric(
          horizontal: WidgetSizes.spacingM + WidgetSizes.spacingXSS,
        );
  const PagePadding.horizontalNormalSymmetric() : super.symmetric(horizontal: WidgetSizes.spacingS);
  const PagePadding.horizontalHighSymmetric() : super.symmetric(horizontal: WidgetSizes.spacingXxl4);
  const PagePadding.horizontalLowSymmetric() : super.symmetric(horizontal: WidgetSizes.spacingXsMid);
  const PagePadding.horizontalVeryLowSymmetric() : super.symmetric(horizontal: WidgetSizes.spacingXxs);
  const PagePadding.horizontalLowXss()
      : super.symmetric(
          horizontal: WidgetSizes.spacingXxs + WidgetSizes.spacingXSS,
        );
  const PagePadding.horizontal16Symmetric() : super.symmetric(horizontal: WidgetSizes.spacingM);

  const PagePadding.verticalSymmetric() : super.symmetric(vertical: WidgetSizes.spacingL);
  const PagePadding.verticalMediumHighSymmetric() : super.symmetric(vertical: WidgetSizes.spacingXxl2);
  const PagePadding.verticalMediumSymmetric() : super.symmetric(vertical: WidgetSizes.spacingM);
  const PagePadding.verticalHigh() : super.symmetric(vertical: WidgetSizes.spacingXxl4);
  const PagePadding.verticalVeryLowSymmetric() : super.symmetric(vertical: WidgetSizes.spacingXxs);
  const PagePadding.verticalNormalSymmetric() : super.symmetric(vertical: WidgetSizes.spacingXl);
  const PagePadding.verticalLowSymmetric() : super.symmetric(vertical: WidgetSizes.spacingXsMid);
  const PagePadding.vertical8Symmetric() : super.symmetric(vertical: WidgetSizes.spacingXs);
  const PagePadding.vertical6Symmetric() : super.symmetric(vertical: WidgetSizes.spacingXSs);
  const PagePadding.vertical12Symmetric() : super.symmetric(vertical: WidgetSizes.spacingS);
  const PagePadding.highVerticalLowHorizontal()
      : super.symmetric(
          vertical: WidgetSizes.spacingXxl4,
          horizontal: WidgetSizes.spacingXsMid,
        );

  const PagePadding.allNormal() : super.all(WidgetSizes.spacingXl);
  const PagePadding.all() : super.all(WidgetSizes.spacingL);
  const PagePadding.allLow() : super.all(WidgetSizes.spacingXsMid);
  const PagePadding.allVeryLow() : super.all(WidgetSizes.spacingXs);
  const PagePadding.generalLowAll() : super.all(WidgetSizes.spacingXsMid);
  const PagePadding.generalAllNormal() : super.all(WidgetSizes.spacingM);
  const PagePadding.generalAllLow() : super.all(WidgetSizes.spacingS);

  const PagePadding.generalCardAll() : super.all(WidgetSizes.spacingS);

  const PagePadding.generalCardOnlyRight() : super.only(right: WidgetSizes.spacingXs);

  const PagePadding.generalIconAll() : super.all(WidgetSizes.spacingXxs);
  const PagePadding.generalIconLowAll() : super.all(WidgetSizes.spacingXSS);
  const PagePadding.generalCircleAll() : super.all(WidgetSizes.spacingXs);

  const PagePadding.onlyLeftIcon() : super.only(left: WidgetSizes.spacingXl);
  const PagePadding.onlyLeft10() : super.only(left: WidgetSizes.spacingXsMid);

  const PagePadding.onlyLeft() : super.only(left: WidgetSizes.spacingM);
  const PagePadding.onlyLeftHigh() : super.only(left: WidgetSizes.spacingXxl2);
  const PagePadding.onlyLeftLow() : super.only(left: WidgetSizes.spacingS);
  const PagePadding.onlyLeftVeryLow() : super.only(left: WidgetSizes.spacingXs);

  const PagePadding.onlyBottomMedium() : super.only(bottom: WidgetSizes.spacingS);
  const PagePadding.onlyBottomNormal() : super.only(bottom: WidgetSizes.spacingXl);
  const PagePadding.onlyBottom() : super.only(bottom: WidgetSizes.spacingM);
  const PagePadding.onlyBottomLow() : super.only(bottom: WidgetSizes.spacingXsMid);
  const PagePadding.onlyBottomVeryLow() : super.only(bottom: WidgetSizes.spacingXxs);

  const PagePadding.onlyTopMedium() : super.only(top: WidgetSizes.spacingS);
  const PagePadding.onlyTop() : super.only(top: WidgetSizes.spacingXsMid);
  const PagePadding.onlyTopNormalMedium() : super.only(top: WidgetSizes.spacingXxl3 / 2);
  const PagePadding.onlyTopVeryLow() : super.only(top: WidgetSizes.spacingXSS);
  const PagePadding.onlyTopLow() : super.only(top: WidgetSizes.spacingXxs);
  const PagePadding.onlyTopLowNormal() : super.only(top: WidgetSizes.spacingXxl3 / 2);
  const PagePadding.onlyTopNormal() : super.only(top: WidgetSizes.spacingXl);
  const PagePadding.onlyTopNormalX() : super.only(top: WidgetSizes.spacingXxl2 - WidgetSizes.spacingXSS);
  const PagePadding.onlyTopHigh() : super.only(top: WidgetSizes.spacingXxl3);

  const PagePadding.onlyRight() : super.only(right: WidgetSizes.spacingM);
  const PagePadding.onlyRightMedium() : super.only(right: WidgetSizes.spacingL);
  const PagePadding.onlyRightNormal() : super.only(right: WidgetSizes.spacingXl);
  const PagePadding.onlyRightHigh() : super.only(right: WidgetSizes.spacingXl + WidgetSizes.spacingM);

  const PagePadding.onlyRightLow() : super.only(right: WidgetSizes.spacingXsMid);
  const PagePadding.onlyRightVeryLow() : super.only(right: WidgetSizes.spacingXSs);

  const PagePadding.horizontalLowVerticalVeryLowSymmetric()
      : super.symmetric(
          horizontal: WidgetSizes.spacingXsMid,
          vertical: WidgetSizes.spacingXxs,
        );
  const PagePadding.boxDesignLowHorizontal()
      : super.fromLTRB(
          WidgetSizes.spacingS,
          WidgetSizes.spacingXSs,
          WidgetSizes.spacingS,
          WidgetSizes.spacingXSs,
        );

  const PagePadding.boxWidgetDesignLowHorizontal()
      : super.fromLTRB(
          WidgetSizes.spacingL,
          WidgetSizes.spacingMx,
          WidgetSizes.spacingL,
          WidgetSizes.spacingXSS,
        );
  const PagePadding.boxWidgetDesignVeryLowHorizontal()
      : super.fromLTRB(
          WidgetSizes.spacingM,
          WidgetSizes.spacingMx,
          WidgetSizes.spacingM,
          WidgetSizes.spacingMx,
        );

  const PagePadding.boxPaddingLT()
      : super.only(
          left: WidgetSizes.spacingL,
          top: WidgetSizes.spacingMx,
        );
}

class PageMargin extends EdgeInsets {
  const PageMargin.leftTopLow()
      : super.only(
          left: WidgetSizes.spacingS,
          top: WidgetSizes.spacingXxl3 / 2,
        );
}
