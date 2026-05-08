import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../networking/dio_factory.dart';
import '../networking/dio_helper.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  await Future.wait([
    Future(() async {
      final sharedPreferences = await SharedPreferences.getInstance();
      getIt.registerSingleton<SharedPreferences>(sharedPreferences);
    }),
  ]);

  final dio = DioFactory.instance;
  getIt.registerLazySingleton<ApiHelper>(() => DioHelperImpl(dio));
}
