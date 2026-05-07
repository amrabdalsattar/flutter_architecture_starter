import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../utils/secured_keys.dart';
import 'flavors_helper.dart';
import 'log_helper.dart';

abstract interface class MonitoringHelper {
  Future<void> init();

  Future<void> log(Object exception, {StackTrace? stackTrace});

  static MonitoringHelper? _instance;
  static MonitoringHelper get instance {
    _instance ??= _SentryImpl();
    return _instance!;
  }
}

class _SentryImpl implements MonitoringHelper {
  @override
  Future<void> init() async {
    if (kDebugMode || FlavorsHelper.isDevelopment) return;
    await SentryFlutter.init((options) {
      options.dsn = _dsn;
      options.sampleRate = 0.5;
    });
  }

  @override
  Future<void> log(Object exception, {StackTrace? stackTrace}) async {
    if (kDebugMode) {
      LogHelper.logError('Monitoring Error: $exception, $stackTrace');
    } else {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }

  static String get _dsn {
    if (FlavorsHelper.isProduction) return SecuredKeys.sentryProdKey;
    return SecuredKeys.sentryStagingKey;
  }
}
