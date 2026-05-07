import 'package:flutter/material.dart';

import '../helpers/flavors_helper.dart';
import 'utils.dart';

abstract class AppInitializer {
  static Future<void> initApp({required Flavor flavor}) async {
    WidgetsFlutterBinding.ensureInitialized();
    _setEnvironment(flavor);
  }

  static void _setEnvironment(Flavor flavor) {
    switch (flavor) {
      case Flavor.development:
        FlavorsHelper.initDevelopment();
        Utils.setBlocObserver();
      case Flavor.staging:
        FlavorsHelper.initStaging();
      case Flavor.production:
        FlavorsHelper.initProduction();
    }
  }
}
