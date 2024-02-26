import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        provisional: true,
        sound: true,
        criticalAlert: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Permission Granted");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("Permission provisional");
    } else {
      print("Permission deinai");
    }
  }

  Future<void> initLocalNotification({RemoteMessage? message}) async {
    var androidInitializationSettings =
    const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {});

    if(message != null) {
      showNotification(message) ;

    }

  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.title.toString());
      print(message.notification!.body.toString());
      initLocalNotification(message: message);
    });

  }

  Future<void> showNotification(RemoteMessage message) async {

    String id = message.notification?.android?.channelId ?? "0" ;
    print("===================================> ${message.notification?.android?.channelId ?? "0"}") ;

    AndroidNotificationChannel channel = AndroidNotificationChannel(
        id,
        "High Importance Notification",
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(channel.id, channel.name,
        channelDescription: "your channel Description",
        importance: Importance.high,
        priority: Priority.high,
        ticker: "ticker");

    DarwinNotificationDetails darwinNotificationDetails =
    const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
          int.parse(id),
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  Future<String> getDeviceFcmToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  onTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      print(event.toString());
    });
  }
}