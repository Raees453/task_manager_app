import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppWidgets {
  static final double fullScreenHorizontalPaddingValue = 24.w;
  static final double fullScreenVerticalPaddingValue = 20.w;
  static final double borderRadiusValue = 28.w;
  static final double halfBorderRadiusValue = borderRadiusValue / 2;
  static final double verticalGapValue = 24.h;
  static final double horizontalGapValue = 24.w;
  static final double dropDownMenuHeight = 300.h;
  static final double viewDocumentHeight = 224.h;

  static final fullScreenPadding = EdgeInsets.symmetric(
    horizontal: fullScreenHorizontalPaddingValue,
  );

  static final fullScreenHorizontalPadding = EdgeInsets.symmetric(
    horizontal: fullScreenHorizontalPaddingValue,
  );

  static final symmetricPadding = EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 12.h,
  );

  static final borderRadius = BorderRadius.circular(borderRadiusValue);

  static final halfBorderRadius = BorderRadius.circular(borderRadiusValue / 2);

  static final verticalGap = SizedBox(height: verticalGapValue);
  static final doubleVerticalGap = SizedBox(height: verticalGapValue * 2);
  static final halfVerticalGap = SizedBox(height: verticalGapValue / 2);

  static final horizontalGap = SizedBox(width: horizontalGapValue);
  static final halfHorizontalGap = SizedBox(width: horizontalGapValue / 2);
}
