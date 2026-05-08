part of 'user_service.dart';

class _UserSecureStorage {
  static const _flutterSecureStorage = FlutterSecureStorage();
  static const _key = 'jwt';
  static String? token;

  static bool get hasToken => token != null;

  static Future<void> cacheToken(String jwt) async {
    token = jwt;
    await _flutterSecureStorage.write(key: _key, value: jwt);
  }

  static Future<void> init() async {
    token = await _flutterSecureStorage.read(key: _key);
  }

  static Future<void> removeToken() async {
    token = null;
    await _flutterSecureStorage.delete(key: _key);
  }
}
