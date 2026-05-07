import 'dart:ui';

import '../models/font_model.dart';

class AppFonts {
  AppFonts._();

  static const FontModel arabic = FontModel(
    primaryFont: 'Tajawal',
    secondaryFont: 'IBM Plex Sans Arabic',
  );

  static const FontModel english = FontModel(
    primaryFont: 'Syne',
    secondaryFont: 'Inter',
  );

  static const FontModel french = FontModel(
    primaryFont: 'Syne',
    secondaryFont: 'Inter',
  );

  static const FontModel fallback = english;
}

class FontResolver {
  FontResolver._();

  static const Map<String, FontModel> _fontMap = {
    'ar': AppFonts.arabic,
    'en': AppFonts.english,
    'fr': AppFonts.french,
  };

  static FontModel resolve(Locale locale) {
    return _fontMap[locale.languageCode] ?? AppFonts.fallback;
  }
}
