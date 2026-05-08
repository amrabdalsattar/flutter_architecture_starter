import 'package:firebase_core/firebase_core.dart';

import '../di/dependency_injection.dart';

abstract class AppInitialSetup {
  static Future<void> init() async {
    await Future.wait([
      setupGetIt(),
      Firebase.initializeApp(
        //TODO: Add firebase options here if you are using firebase in your app
        // options: DefaultFirebaseOptions.currentPlatform
      ),
    ]);
  }
}
