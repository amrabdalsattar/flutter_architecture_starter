import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/dependency_injection.dart';
import 'localization_cubit/localization_cubit.dart';

class LocalizationHelper {
  LocalizationHelper._();

  static String? localeLanguage;

  static final _prefs = getIt<SharedPreferences>();
  static final _localizationCubit = LocalizationCubit(_prefs);

  static bool get isArabic => _localizationCubit.isArabic;
  static bool get canChangeLanguage => _localizationCubit.canChangeLanguage;

  static TextDirection get textDirection =>
      isArabic ? TextDirection.rtl : TextDirection.ltr;
  static void toggleLocale(BuildContext context) {
    if (canChangeLanguage) {
      _localizationCubit.toggleLocale(context);
    }
  }

  static Widget init({required Widget child}) {
    _localizationCubit.init();
    localeLanguage =
        _prefs.getString(LocalizationCubit.localeKey) ??
        LocalizationCubit.defaultLocale.languageCode;

    return el.EasyLocalization(
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: Locale(localeLanguage!),
      supportedLocales: LocalizationCubit.supportedLocales,
      child: BlocProvider.value(value: _localizationCubit, child: child),
    );
  }
}
