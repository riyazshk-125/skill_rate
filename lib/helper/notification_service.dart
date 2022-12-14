/*
// Dart imports:
import 'dart:io';

// Package imports:
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  //NotificationService a singleton object
  static final NotificationService notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return notificationService;
  }

  NotificationService._internal();

  static const channelId = '123';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: null,
    );

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (value) {});
  }

  AndroidNotificationDetails androidNotificationDetails() =>
      const AndroidNotificationDetails(
        'channel ID',
        'channel name',
        channelDescription: 'channel description',
        playSound: true,
        priority: Priority.high,
        importance: Importance.high,
        enableVibration: true,

        // largeIcon: ByteArrayAndroidBitmap.fromBase64String(base64Image),
        // sound: const RawResourceAndroidNotificationSound('slow_spring_board'),
      );
  IOSNotificationDetails iOSPlatformChannelSpecifics =
      const IOSNotificationDetails(
    threadIdentifier: '0',
    sound: "default",
    presentSound: true,
    presentAlert: true,
  );

  Future<void> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            // critical: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            // critical: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      // setState(() {
      //   _notificationsEnabled = granted ?? false;
      // });
    }
  }

  Future<void> showNotifications({
    String? imageUrl,
    String? titleText,
    String? bodyText,
  }) async {
    // flutterLocalNotificationsPlugin.initialize;
    // String base64Image = await ConstMethods.networkImageToBase64(imageUrl!);
    await flutterLocalNotificationsPlugin.show(
      0,
      titleText,
      bodyText,
      NotificationDetails(
        android: androidNotificationDetails(),
        iOS: iOSPlatformChannelSpecifics,
      ),
      payload: "Hey User",
    );
  }

  Future<void> scheduleNotifications() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      "Notification Title",
      "This is the Notification Body!",
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      NotificationDetails(android: androidNotificationDetails()),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
*/
