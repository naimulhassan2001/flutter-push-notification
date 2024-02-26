import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:push_notification/services/dynamic_link_service.dart';
import 'package:push_notification/services/notification_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationService notificationService = NotificationService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Push Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  // send notification from one device to another
                  notificationService.getDeviceFcmToken().then((value) async {
                    print("==============================> token  $value");
                    var data = {
                      /// ================================ >siam vai <=================================
                      /// cFdEsnLoTAyLjriUFzHAzC:APA91bEgBMh-WvKkUnJN5ezXGerxyMgYcIGZn16a6J86y5AaQdvC-FblPczeveij6HyJg5gODBJB7-8kRx_2p6J16SccgpflmgTsOSQ4nB9suLA-roUjyqCQwnzpPGTg6_9GFJe7iqa3
                      'to':
                          "cFdEsnLoTAyLjriUFzHAzC:APA91bEgBMh-WvKkUnJN5ezXGerxyMgYcIGZn16a6J86y5AaQdvC-FblPczeveij6HyJg5gODBJB7-8kRx_2p6J16SccgpflmgTsOSQ4nB9suLA-roUjyqCQwnzpPGTg6_9GFJe7iqa3",
                      // 'to': value,
                      'notification': {
                        'title': 'Naimul Hassan',
                        'body': 'kobe',
                        'sound': 'notification.mp3',
                        "android_channel_id": "1",
                        'android': {
                          "android_channel_id": "2",
                          'channel_id': '1', // Set your desired channel ID
                        },
                      },
                      'data': {
                        'type': 'msj',
                        'id': 'Asif Taj',
                      }
                    };

                    await http.post(
                      Uri.parse('https://fcm.googleapis.com/fcm/send'),
                      body: jsonEncode(data),
                      headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                        'Authorization':
                            'key=AAAAR7oGxHw:APA91bFlmoX6lO3I6q1vfC2stVlxOLfE-TCJtVAFtOzFX1f6czxAOesKBfBbSUacttJiAXMms2FMniiPgo7Dwgn5Y0gvKcoptQw0bjOftp0qAA21uoaRmU_bs9C7q1e1ET7AY7WcbS8b'
                      },
                    ).then((value) {
                      if (kDebugMode) {
                        print(value.body.toString());
                      }
                    }).onError((error, stackTrace) {
                      if (kDebugMode) {
                        print(error);
                      }
                    });
                  });
                },
                child: const Text('Send Notifications')),
            TextButton(
                onPressed: () => DynamicLinkService.instance.createDynamicLink(),
                child: const Text('create short Link')),
          ],
        ),
      ),
    );
  }
}
