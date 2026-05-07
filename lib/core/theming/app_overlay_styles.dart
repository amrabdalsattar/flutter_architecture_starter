import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppOverlayStyles {
  const AppOverlayStyles._();
  static const allWhite = SystemUiOverlayStyle(
    statusBarColor: AppColors.surface,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.surface,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
