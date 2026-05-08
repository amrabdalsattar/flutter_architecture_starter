import 'package:flutter/foundation.dart';

class FlavorsHelper {
  const FlavorsHelper._();

  static late Flavor _flavor;

  static void initDevelopment() => _flavor = Flavor.development;
  static void initProduction() => _flavor = Flavor.production;
  static void initStaging() => _flavor = Flavor.staging;

  static bool get isDevelopment => _flavor == Flavor.development;
  static bool get isProduction => _flavor == Flavor.production;
  static bool get isStaging => _flavor == Flavor.staging;

  static bool get isLive => kReleaseMode && isProduction;
  static List<String> get fcmTopics => _flavor.fcmTopics;

  static String get apiBaseUrl => '${_flavor.baseUrl}api/';
}

enum Flavor {
  development('', ['all', 'development']),
  production('', ['all', 'production']),
  staging('', ['all', 'staging']);

  final String baseUrl;
  final List<String> fcmTopics;

  const Flavor(this.baseUrl, this.fcmTopics);
}
