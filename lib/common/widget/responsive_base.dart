import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveBaseWidget extends StatelessWidget {
  // DP Pixel
  static const double baseMobileWidth = 1280;
  static const double baseMobileHeight = 800;

  // DP Pixel
  static const double baseTabletWidth = 1000;

  // DP Pixel for iMin D4
  static const double baseExtraTabletWidth = 1366;

  //DP Pixel for iMin M2 Max
  static const double baseSmallWidth = 580;

  final Widget mobile;
  final Widget tablet;

  const ResponsiveBaseWidget({
    Key? key,
    required this.mobile,
    required this.tablet,
  }) : super(key: key);

  static bool get isMobile =>
      ScreenUtil().screenWidth < baseTabletWidth &&
      ScreenUtil().orientation != Orientation.landscape;

  static bool get isTablet =>
      ScreenUtil().screenWidth >= baseTabletWidth ||
      ScreenUtil().orientation == Orientation.landscape;

  static bool get isExtraTablet =>
      ScreenUtil().screenWidth >= baseExtraTabletWidth;

  static bool get isSmallTablet =>
      ScreenUtil().screenWidth >= baseSmallWidth &&
      ScreenUtil().screenWidth < baseTabletWidth;

  static bool get isMediumTablet =>
      ScreenUtil().screenWidth >= baseMobileWidth &&
      ScreenUtil().screenWidth < baseExtraTabletWidth;

  static int get rowProductInShelfPage {
    final int currentCount = (ScreenUtil().screenWidth ~/ 330).toInt();
    const int minCount = 3;
    return max(currentCount, minCount);
  }

  static int ratioRowCartItems(int index) {
    try {
      // The sum of arrays must be 100(%), based on % of child widget.
      return <int>[28, 24, 24, 24][index - 1];
    } catch (e) {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isTablet) {
      return tablet;
    } else {
      return mobile;
    }
  }
}

class ResponsiveValue<T> {
  final T? mobile;
  final T? tablet;
  final T? extraTablet;

  ResponsiveValue({
    this.mobile,
    this.tablet,
    this.extraTablet,
  });

  T? value() {
    if (ResponsiveBaseWidget.isExtraTablet) {
      return extraTablet;
    } else if (ResponsiveBaseWidget.isTablet) {
      return tablet;
    }
    return mobile;
  }
}

extension ResponsiveExtension on double {
  double dotR(bool active) {
    return active ? r : this;
  }
}
