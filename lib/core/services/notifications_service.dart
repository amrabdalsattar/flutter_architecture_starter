import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../helpers/active_chat_tracker.dart';
import '../helpers/flavors_helper.dart';
import '../services/user_service/user_service.dart';
import 'deep_links_service/deeplink_model.dart';
import 'deep_links_service/deeplinks_handler.dart';

class NotificationsService {
  NotificationsService._internal();

  static final _notifications = NotificationsService._internal();

  static NotificationsService get instance => _notifications;

  final _firebaseMessaging = FirebaseMessaging.instance;
  static const _usersTopic = 'allUsers';

  Future<String?> getToken() async {
    try {
      return _firebaseMessaging.getToken();
    } catch (_) {
      return null;
    }
  }

  Future<void> initNotifications() async {
    await _requestPermission();
    _initPushNotifications();
    _LocalNotificationsHandler.instance.initNotifications();

    _firebaseMessaging.subscribeToTopic(_usersTopic);
    for (var topic in FlavorsHelper.fcmTopics) {
      _firebaseMessaging.subscribeToTopic(topic);
    }
    if (UserService.userModel != null) {
      _firebaseMessaging.subscribeToTopic('users');
    }
  }

  Future<void> _requestPermission() async {
    await _firebaseMessaging.requestPermission();
  }

  Future<void> deleteToken() async {
    _firebaseMessaging.deleteToken();
    _firebaseMessaging.unsubscribeFromTopic(_usersTopic);
  }

  Future<void> _initPushNotifications() async {
    _getInitialMessage();
    _setForegroundOptions();
    _onMessage();
    _onMessageOpenedApp();
    _onBackgroundMessage();
  }

  Future<void> _getInitialMessage() async {
    final message = await _firebaseMessaging.getInitialMessage();
    _onBackgroundCallback(message);
  }

  void _setForegroundOptions() {
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _onForegroundCallback(RemoteMessage message) {
    final notification = message.notification;
    final title = notification?.title;
    final body = notification?.body;
    if (notification != null && title != null && body != null) {
      final title = message.notification!.title;
      final body = message.notification!.body;

      final model = DeeplinkModel.fromJson(message.data);

      // Don't show notification if user is currently in the same chat
      if (DeeplinkHandler.isChatDeeplink(model) &&
          ActiveChatTracker.isActiveSession(model.id)) {
        return;
      }

      // Pass the data as payload so it can be handled when user taps the notification
      final data = message.data.isNotEmpty ? message.data : null;
      // Encode the data as JSON string for payload
      final payload = data != null ? jsonEncode(data) : null;
      _LocalNotificationsHandler.instance.showNotification(
        title!,
        body!,
        payload,
      );
    } else {
      // MonitoringHelper.instance.log(
      //   'Notification was received with notification: $notification , title: $title, body: $body',
      // );
    }
  }

  StreamSubscription<RemoteMessage> _onMessage() {
    return FirebaseMessaging.onMessage.listen(_onForegroundCallback);
  }

  StreamSubscription<RemoteMessage> _onMessageOpenedApp() =>
      FirebaseMessaging.onMessageOpenedApp.listen(_callback);

  void _onBackgroundMessage() {
    FirebaseMessaging.onBackgroundMessage(_onBackgroundCallback);
  }
}

@pragma('vm:entry-point')
Future<void> _onBackgroundCallback(RemoteMessage? message) async {
  if (message == null) return;
  _callback(message);
}

void _callback(RemoteMessage message) {
  try {
    if (message.data.isNotEmpty) {
      final model = DeeplinkModel.fromJson(message.data);
      return DeeplinkHandler.handle(model);
    }
  } catch (_) {
    // swallow errors so notifications don't crash the app
  }
}

class _LocalNotificationsHandler {
  _LocalNotificationsHandler._internal();
  static final _notifications = _LocalNotificationsHandler._internal();
  static _LocalNotificationsHandler get instance => _notifications;

  final _localNotificationsHandler = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    _localNotificationsHandler.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    if (Platform.isAndroid) {
      _localNotificationsHandler
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()!
          .requestNotificationsPermission();
    }
  }

  Future<void> showNotification(
    String title,
    String body,
    String? payload,
  ) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const iosPlatformChannelSpecifics = DarwinNotificationDetails();

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    await _localNotificationsHandler.show(
      id: 0,
      title: title,
      body: body,
      notificationDetails: platformChannelSpecifics,
      payload: payload,
    );
  }

  void _onNotificationTapped(NotificationResponse response) {
    try {
      final payload = response.payload;
      if (payload != null && payload.isNotEmpty) {
        final model = DeeplinkModel.fromJson(jsonDecode(payload));
        DeeplinkHandler.handle(model);
      }
    } catch (_) {
      // swallow errors
    }
  }
}
