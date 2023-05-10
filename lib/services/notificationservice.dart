import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lifelist/constants/index.dart';
import 'package:lifelist/utils/utils.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(APP_LOGO);

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    bool? isPermissionGranted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    if (isPermissionGranted == true) {
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    }
  }

  void scheduleNotification(String title, String body, int id, bool isCompleted,
      DateTime deadline) async {
    final timeToNotify = getNotificationScheduleTime(deadline, isCompleted);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        timeToNotify,
        const NotificationDetails(
            android: AndroidNotificationDetails(
                NOTIFICATION_CHANNEL_ID, NOTIFICATION_CHANNEL_NAME,
                channelDescription: NOTIFICATION_CHANNEL_DESCRIPTION)),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
