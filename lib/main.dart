import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:push_notification/services/notification_services.dart';
import 'package:push_notification/view/screen/home_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationService notificationService = NotificationService() ;
  @override
  void initState() {
    notificationService.initLocalNotification() ;
    notificationService.requestNotificationPermission() ;
    notificationService.firebaseInit() ;
    notificationService.getDeviceFcmToken().then((value) {
      print(value) ;
    });
    notificationService.onTokenRefresh() ;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}