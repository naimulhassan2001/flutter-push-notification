import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:push_notification/services/notification_services.dart';
import 'package:push_notification/view/screen/home_screen.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(
      "===================================> ${message.notification?.android?.channelId ?? "0"}");
  NotificationService notificationService = NotificationService();
  notificationService.initLocalNotification(message: message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    notificationService.initLocalNotification();
    notificationService.requestNotificationPermission();
    notificationService.firebaseInit();
    notificationService.getDeviceFcmToken().then((value) {
      print(value);
    });
    notificationService.onTokenRefresh();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
  Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      print("jkfdsjfdjlskjfkldsjkl") ;
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

}


