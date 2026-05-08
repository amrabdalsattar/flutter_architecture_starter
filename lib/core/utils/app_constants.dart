import 'dart:io';

class AppConstants {
  static String get storeUrl {
    return Platform.isAndroid ? 'Android_URL' : 'iOS_URL';
  }
}
