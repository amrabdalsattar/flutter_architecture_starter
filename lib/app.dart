import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/helpers/localization/locale_keys.dart';
import 'core/services/deep_links_service/deeplinks_handler.dart';
import 'core/services/user_service/user_service.dart';
import 'core/theming/app_sizer.dart';
import 'core/theming/app_theming.dart';
import 'core/utils/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DeeplinkHandler.init();
    return LayoutBuilder(
      builder: (context, _) {
        AppSizer.initialize(context);
        return const _MaterialApp();
      },
    );
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: LocaleKeys.common.appName,
      navigatorKey: UserService.navigatorKey,
      theme: AppTheming.lightTheme(context.locale),
      darkTheme: AppTheming.darkTheme(context.locale),
      home: AppRouter.home,
    );
  }
}
