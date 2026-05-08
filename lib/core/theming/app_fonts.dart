import 'dart:ui';

import '../models/font_model.dart';

class AppFonts {
  AppFonts._();

  static const FontModel _arabic = FontModel(
    primaryFont: 'Tajawal',
    secondaryFont: 'IBM Plex Sans Arabic',
  );

  static const FontModel _english = FontModel(
    primaryFont: 'Syne',
    secondaryFont: 'Inter',
  );

  static const FontModel fallback = _english;
}

class FontResolver {
  FontResolver._();

  static const Map<String, FontModel> _fontMap = {
    'ar': AppFonts._arabic,
    'en': AppFonts._english,
  };

  static FontModel resolve(Locale locale) {
    return _fontMap[locale.languageCode] ?? AppFonts.fallback;
  }
}
