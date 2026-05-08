import 'package:flutter/material.dart';

import '../../app.dart';
import '../helpers/flavors_helper.dart';
import 'app_initial_setup.dart';
import 'utils.dart';

abstract class AppRunner {
  static Future<void> runDev() => _bootstrap(Flavor.development);
  static Future<void> runProd() => _bootstrap(Flavor.production);
  static Future<void> runStaging() => _bootstrap(Flavor.staging);

  static Future<void> _bootstrap(Flavor flavor) async {
    WidgetsFlutterBinding.ensureInitialized();

    _setEnvironment(flavor);

    await AppInitialSetup.init();

    runApp(const MyApp());
  }

  static void _setEnvironment(Flavor flavor) {
    switch (flavor) {
      case Flavor.development:
        FlavorsHelper.initDevelopment();
        AppUtils.setBlocObserver();
      case Flavor.staging:
        FlavorsHelper.initStaging();
      case Flavor.production:
        FlavorsHelper.initProduction();
    }
  }
}
