part of 'user_service.dart';

class _UserRemoteDataSource {
  static final _apiHelper = getIt<ApiHelper>();
  static Future<void> logout() async {
    await tryCatchBlock(() async {
      final token = await NotificationsService.instance.getToken();
      await _apiHelper.postData(
        ApiRequestModel(
          endPoint: ApiConstants.logout,
          body: {'deviceToken': token},
        ),
      );
    });
  }

  static Future<void> deleteAccount() async {
    await tryCatchBlock(() async {
      final token = await NotificationsService.instance.getToken();
      await _apiHelper.postData(
        ApiRequestModel(
          endPoint: ApiConstants.deleteAccount,
          body: {'deviceToken': token},
        ),
      );
    });
  }
}
