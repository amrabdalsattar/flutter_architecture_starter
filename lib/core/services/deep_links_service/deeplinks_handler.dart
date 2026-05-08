import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/services/user_service/user_service.dart';
import '../../extensions/navigations.dart';
import 'deeplink_model.dart';

class DeeplinkHandler {
  static final _appLinks = AppLinks();
  static void init() async {
    final uri = await _appLinks.getInitialLink();
    if (uri != null) {
      _handleUri(uri);
    }

    _appLinks.uriLinkStream.listen(DeeplinkHandler._handleUri);
  }

  static void _handleUri(Uri uri) async {
    final model = DeeplinkModel.fromJson(uri.queryParameters);
    handle(model);
  }

  static void handle(DeeplinkModel model) async {
    try {
      UserService.navigatorKey.currentContext?.push(widget: _getScreen(model)!);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static const _chatRoute = 'chat';

  static Widget? _getScreen(DeeplinkModel model) {
    //TODO: implement this method to return the correct screen based on the route in the model
    return switch (model.route) {
      '' => null,
      _ => null,
    };
  }

  static bool isChatDeeplink(DeeplinkModel model) => model.route == _chatRoute;
}
