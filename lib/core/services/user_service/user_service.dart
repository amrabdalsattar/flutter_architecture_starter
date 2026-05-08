import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/login/ui/login_screen.dart';
import '../../di/dependency_injection.dart';
import '../../helpers/localization/locale_keys.dart';
import '../../helpers/log_helper.dart';
import '../../models/user_model.dart';
import '../../networking/api_constants.dart';
import '../../networking/api_request_model.dart';
import '../../networking/dio_helper.dart';
import '../../utils/app_utils.dart';
import '../../utils/extensions.dart';
import '../notifications_service.dart';

part 'user_local_data_source.dart';
part 'user_remote_data_source.dart';
part 'user_secure_storage.dart';

class UserService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static SubUserModel? get userModel => _UserLocalDataSource.userModel;

  static Future<void> cacheUser(UserModel userModel) async {
    await Future.wait([
      _UserLocalDataSource.cacheUserModel(userModel),
      _UserSecureStorage.cacheToken(userModel.token),
    ]);
  }

  static Future<void> clearUser({bool deleteAccount = false}) async {
    if (!userModel!.isGuest) {
      _UserLocalDataSource.clearUserModel();
      _UserSecureStorage.removeToken();

      if (deleteAccount) {
        await _UserRemoteDataSource.deleteAccount();
      } else {
        await _UserRemoteDataSource.logout();
      }
      await getIt.reset();
      await setupGetIt();
      navigatorKey.currentContext?.pushAndRemoveUntil(
        widget: const LoginScreen(),
      );
    }
  }

  static Future<void> init() async {
    _UserLocalDataSource.init();
    await _UserSecureStorage.init();
  }

  static bool get hasToken => _UserSecureStorage.hasToken && userModel != null;
  static String? get token => _UserSecureStorage.token;

  static Future<void> cacheToken(String token) async {
    await _UserSecureStorage.cacheToken(token);
  }

  static final _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json, image/*',
  };

  static Map<String, String> getHeaders() {
    if (hasToken) {
      _headers.addAll({'Authorization': 'Bearer $token'});
    }
    return _headers;
  }
}

Future<void> showDeleteAccountDialog(BuildContext context) async {
  context.showAlertDialog(
    title: LocaleKeys.account.deleteAccount,
    subTitle: LocaleKeys.account.deleteAccountMessage,
    confirmText: LocaleKeys.common.delete,
    onConfirm: () async {
      context.pop();
      context.showLoadingAlertDialog();
      await UserService.clearUser(deleteAccount: true);
    },
  );
}
