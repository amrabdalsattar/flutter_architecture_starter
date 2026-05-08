import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../di/dependency_injection.dart';
import '../helpers/monitoring_helper.dart';
import '../services/notifications_service.dart';
import '../services/user_service/user_service.dart';
import '../theming/app_sizer.dart';

abstract class AppInitialSetup {
  static Future<void> init() async {
    await Future.wait([
      setupGetIt(),
      Firebase.initializeApp(
        //TODO: Add firebase options here if you are using firebase in your app
        // options: DefaultFirebaseOptions.currentPlatform
      ),
    ]);

    await EasyLocalization.ensureInitialized();

    await Future.wait([
      AppSizer.ensureScreenSize(),
      UserService.init(),
      MonitoringHelper.instance.init(),
      // lock the app to portrait mode
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
      // Notifications service
      NotificationsService.instance.initNotifications(),
    ]);

    FlutterError.onError = (FlutterErrorDetails details) {
      MonitoringHelper.instance.log(
        details.exception,
        stackTrace: details.stack,
      );
    };
  }
}
