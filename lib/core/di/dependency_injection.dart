import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  await Future.wait([
    Future(() async {
      final sharedPreferences = await SharedPreferences.getInstance();
      getIt.registerSingleton<SharedPreferences>(sharedPreferences);
    }),
  ]);

}
