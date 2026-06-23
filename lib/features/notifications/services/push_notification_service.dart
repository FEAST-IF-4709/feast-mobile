import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

/// Top-level background/killed-state FCM handler (must be top-level).
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage _) async {
  // OS shows the notification automatically when the payload has a
  // `notification` block. No widget code is safe here.
}

class PushNotificationService {
  PushNotificationService._();

  static final _fln = FlutterLocalNotificationsPlugin();
  static const _channelId = 'feast_orders';
  static const _channelName = 'Order Updates';

  /// Set by [FeastApp] after the router is created so notification taps
  /// can drive navigation without needing a BuildContext.
  static GoRouter? _router;

  static void setRouter(GoRouter router) => _router = router;

  // ---------------------------------------------------------------------------
  // Init — call once after a successful login.
  // ---------------------------------------------------------------------------

  static Future<void> init(Dio dio) async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _initLocalNotifications();
    await _requestPermission();
    await _registerToken(dio);
    _handleForeground();
    _handleNotificationTap();
  }

  // ---------------------------------------------------------------------------
  // Cleanup — call on logout.
  // ---------------------------------------------------------------------------

  static Future<void> deleteToken(Dio dio) async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token == null) return;
    try {
      await dio.delete<void>('/api/v1/auth/device-tokens/$token/');
    } on DioException catch (_) {}
    await FirebaseMessaging.instance.deleteToken();
  }

  // ---------------------------------------------------------------------------
  // Permission
  // ---------------------------------------------------------------------------

  static Future<void> _requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // ---------------------------------------------------------------------------
  // Token
  // ---------------------------------------------------------------------------

  static Future<void> _registerToken(Dio dio) async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) await _sendToken(dio, token);

    FirebaseMessaging.instance.onTokenRefresh.listen(
      (t) => _sendToken(dio, t),
    );
  }

  static Future<void> _sendToken(Dio dio, String token) async {
    try {
      await dio.post<void>(
        '/api/v1/auth/device-tokens/',
        data: {
          'token': token,
          'platform': defaultTargetPlatform == TargetPlatform.iOS
              ? 'ios'
              : 'android',
        },
      );
    } on DioException catch (_) {}
  }

  // ---------------------------------------------------------------------------
  // Local notifications setup
  // ---------------------------------------------------------------------------

  static Future<void> _initLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinInit = DarwinInitializationSettings();

    await _fln.initialize(
      const InitializationSettings(android: androidInit, iOS: darwinInit),
      onDidReceiveNotificationResponse: (details) =>
          _routeFromPayload(details.payload),
    );

    await _fln
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            _channelId,
            _channelName,
            importance: Importance.high,
          ),
        );
  }

  // ---------------------------------------------------------------------------
  // Foreground → show via flutter_local_notifications
  // ---------------------------------------------------------------------------

  static void _handleForeground() {
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _fln.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: jsonEncode(message.data),
      );
    });
  }

  // ---------------------------------------------------------------------------
  // Tap on notification (background / terminated)
  // ---------------------------------------------------------------------------

  static void _handleNotificationTap() {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (m) => _routeFromData(m.data),
    );
    FirebaseMessaging.instance.getInitialMessage().then((m) {
      if (m != null) _routeFromData(m.data);
    });
  }

  // ---------------------------------------------------------------------------
  // Navigation helpers
  // ---------------------------------------------------------------------------

  static void _routeFromPayload(String? payload) {
    if (payload == null) return;
    try {
      _routeFromData(jsonDecode(payload) as Map<String, dynamic>);
    } catch (_) {}
  }

  static void _routeFromData(Map<String, dynamic> data) {
    final orderId = data['order_id'] as String?;
    if (orderId == null || _router == null) return;
    _router!.push('/order-tracking/$orderId');
  }
}
