part of 'user_service.dart';

class _UserLocalDataSource {
  static final _prefs = getIt<SharedPreferences>();
  static const _key = 'user_data';
  static SubUserModel? _userModel;
  static SubUserModel get userModel {
    if (_userModel != null) return _userModel!;

    init();
    return SubUserModel.guest();
  }

  static Future<void> cacheUserModel(SubUserModel userModel) async {
    _userModel = userModel;

    await _prefs.setString(_key, jsonEncode(userModel.toJson()));
    LogHelper.logSuccess('Cached User : ${userModel.toJson()}');
  }

  static Future<void> clearUserModel() async {
    _userModel = null;

    await _prefs.remove(_key);
    LogHelper.logSuccess('Cleared User');
  }

  static void init() {
    final userDataAsString = _prefs.getString(_key);
    if (userDataAsString == null) return;

    _userModel = SubUserModel.fromJson(jsonDecode(userDataAsString));
    LogHelper.logSuccess('Retrieved User : $userDataAsString');
  }
}
