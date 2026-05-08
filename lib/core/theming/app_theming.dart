import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

abstract class AppTheming {
  static SystemUiOverlayStyle get light => const SystemUiOverlayStyle(
    statusBarColor: AppColors.white,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  static SystemUiOverlayStyle get dark => const SystemUiOverlayStyle(
    statusBarColor: AppColors.black,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  static ThemeData lightTheme(Locale locale) => ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.surface,
    fontFamily: FontResolver.resolve(locale).primaryFont,
  );

  static ThemeData darkTheme(Locale locale) => ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.surface,
    fontFamily: FontResolver.resolve(locale).primaryFont,
  );
}
