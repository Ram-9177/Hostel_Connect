import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidInit, iOS: iosInit);

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) async {
        try {
          final payload = response.payload;
          if (payload == null) return;
          final data = jsonDecode(payload) as Map<String, dynamic>;
          final actionId = response.actionId ?? response.notificationResponseType.name;
          // Re-dispatch via method channel or app-level event bus as needed.
          debugPrint('Notification action: $actionId, payload: $data');
        } catch (_) {}
      },
    );
  }

  Future<void> showMealNotification({
    required String mealType, // 'lunch' | 'dinner'
    required String title,
    required String body,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'meal_channel',
      'Meal Notifications',
      channelDescription: 'Actionable meal prompts',
      importance: Importance.max,
      priority: Priority.high,
      actions: const <AndroidNotificationAction>[
        AndroidNotificationAction('meal_yes', 'Yes', showsUserInterface: true),
        AndroidNotificationAction('meal_no', 'No', showsUserInterface: true),
        AndroidNotificationAction('meal_same_yesterday', 'Same as Yesterday', showsUserInterface: true),
      ],
    );

    const iosDetails = DarwinNotificationDetails();

    await _plugin.show(
      mealType.hashCode,
      title,
      body,
      NotificationDetails(android: androidDetails, iOS: iosDetails),
      payload: jsonEncode({'mealType': mealType}),
    );
  }
}


