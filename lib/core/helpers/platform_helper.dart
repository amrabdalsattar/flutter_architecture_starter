import 'dart:io';

import 'package:flutter/material.dart';

class PlatformHelper {
  const PlatformHelper._();

  static bool get isMobile => Platform.isAndroid || Platform.isIOS;
  static bool get isDesktop => Platform.isWindows || Platform.isMacOS;

  static Widget getPlatformWidget({
    required Widget mobileWidget,
    required Widget desktopWidget,
  }) {
    return isDesktop ? desktopWidget : mobileWidget;
  }
}
