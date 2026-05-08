import 'package:flutter/material.dart';

import '../../features/home/ui/home_screen.dart';
import '../../features/login/ui/login_screen.dart';
import '../../features/onboarding/ui/onboarding_screen.dart';
import '../helpers/onboarding_screen_helper.dart';
import '../services/user_service/user_service.dart';

class AppRouter {
  const AppRouter._();

  static Widget get home {
    if (!OnboardingScreenHelper.hasViewedOnboardingScreen()) {
      return const OnboardingScreen();
    }

    if (UserService.hasToken) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}
