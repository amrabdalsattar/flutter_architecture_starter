import 'package:shared_preferences/shared_preferences.dart';

import '../di/dependency_injection.dart';

class OnboardingScreenHelper {
  static final _prefs = getIt<SharedPreferences>();
  static final String _key = 'hasViewedOnboardingScreen';

  static bool hasViewedOnboardingScreen() {
    return _prefs.getBool(_key) ?? false;
  }

  static Future<void> setOnboardingViewed() async {
    await _prefs.setBool(_key, true);
  }
}
