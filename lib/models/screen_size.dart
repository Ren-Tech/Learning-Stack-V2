import 'package:flutter/material.dart';

enum ScreenSize { small, medium, large }

class ScreenSizeUtils {
  static ScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return ScreenSize.small;
    if (width < 900) return ScreenSize.medium;
    return ScreenSize.large;
  }
}
