import 'dart:developer';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  static const localeKey = 'app_locale';
  static const List<Locale> supportedLocales = [
    Locale('ar'),
    Locale('en'),
    Locale('es'),
  ];

  static Locale get defaultLocale {
    final systemLanguage = PlatformDispatcher.instance.locale.languageCode;
    return supportedLocales.map((l) => l.languageCode).contains(systemLanguage)
        ? Locale(systemLanguage)
        : const Locale('en');
  }

  final SharedPreferences _prefs;
  LocalizationCubit(this._prefs)
    : super(LocalizationState(locale: defaultLocale));

  void init() {
    final languageCode = _prefs.getString(localeKey);

    log('languageCode: $languageCode');

    if (languageCode != null) {
      emit(state.copyWith(locale: Locale(languageCode)));
    }
  }

  Future<void> changeLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) return;
    if (state.locale == locale) return;

    await _prefs.setString(localeKey, locale.languageCode);

    emit(state.copyWith(locale: locale));
  }

  Future<void> toggleLocale(BuildContext context) async {
    if (!canChangeLanguage) return;
    final newLocale = isArabic ? const Locale('en') : const Locale('ar');
    await EasyLocalization.of(context)!.setLocale(newLocale);
    await changeLocale(newLocale);
  }

  bool get isArabic => state.locale.languageCode == 'ar';

  bool get canChangeLanguage => state.locale.languageCode != 'es';
}
