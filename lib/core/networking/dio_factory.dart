import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../helpers/flavors_helper.dart';
import '../services/user_service/user_service.dart';

class DioFactory {
  const DioFactory._();
  static Dio? _dio;

  static Dio get instance {
    if (_dio != null) return _dio!;

    _dio = Dio()
      ..options.baseUrl = FlavorsHelper.apiBaseUrl
      ..options.connectTimeout = const Duration(seconds: 20)
      ..options.receiveTimeout = const Duration(seconds: 20)
      ..interceptors.addAll([
        if (!kReleaseMode)
          PrettyDioLogger(
            requestBody: true,
            requestHeader: true,
            responseHeader: true,
            responseBody: true,
            error: true,
          ),
        _getAuthorizationInterceptor(),
      ]);
    return _dio!;
  }

  static InterceptorsWrapper _getAuthorizationInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers.addAll(UserService.getHeaders());

        return handler.next(options);
      },
      onResponse: (response, handler) async {
        if (response.statusCode == 401) await UserService.clearUser();

        return handler.next(response);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) await UserService.clearUser();

        return handler.next(error);
      },
    );
  }
}
