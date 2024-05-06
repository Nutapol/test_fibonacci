import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/common/size_dimension/app_dimensions.dart';
import 'package:test_app/gen/font_app.dart';

class SPFTypography {
  final String fontFamily;
  final double lineHeight;
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;

  SPFTypography({
    required this.fontFamily,
    required this.lineHeight,
    required this.fontSize,
    required this.fontWeight,
    required this.letterSpacing,
  });
}

class SpotifyTypography {
  final String fontFamily;

  SpotifyTypography(this.fontFamily);

  static SpotifyTypography poppins() => SpotifyTypography(
        FontFamily.poppins,
      );

  static TextStyle _primary() {
    return TextStyle(fontFamily: poppins().fontFamily);
  }

  static TextStyle textStyle({
    required SPFTypography typography,
    required Color? color,
    TextDecoration? decoration,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    double? letterSpacing,
  }) {
    return _primary().copyWith(
      fontSize: typography.fontSize,
      fontWeight: fontWeight ?? typography.fontWeight,
      color: color,
      height: typography.lineHeight,
      fontFamily: typography.fontFamily,
      decoration: decoration,
      overflow: overflow,
      letterSpacing: letterSpacing,
    );
  }

  SPFTypography titleAppbar() {
    const double fontSize = AppDimensions.size20;
    return SPFTypography(
      fontFamily: fontFamily,
      lineHeight: AppDimensions.size20.h / fontSize.h,
      fontSize: fontSize.h,
      fontWeight: FontWeight.w400,
      letterSpacing: AppDimensions.size3,
    );
  }
}
