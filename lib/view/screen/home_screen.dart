import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:push_notification/services/notification_services.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationService notificationService = NotificationService() ;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Push Notification"),

      ),
      body: Center(
        child: TextButton(onPressed: (){

          // send notification from one device to another
          notificationService.getDeviceFcmToken().then((value) async {
            var data = {
              'to': "cud1l-8UT6Gv77pEv4AA1v:APA91bH1e9QhRd3btXPqwH3SwVYYu1cF6gqHhSJAfTh0yBU3gbI_HktUsWNItFf2FozNmJK28UEJ3RiLXEaCCQxFF0BPZxbIbLV8lG-05YWoGnzfHrCT8SKPCWCsRG_V8-rJqk3isT1t",
              'notification': {
                'title': 'Asif',
                'body': 'Subscribe to my channel',
                'sound': 'jetsons_doorbell.mp3',
                "android_channel_id" : "1",
                'android': {
                  "android_channel_id" : "2",
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
                'Authorization': 'key=AAAAR7oGxHw:APA91bFlmoX6lO3I6q1vfC2stVlxOLfE-TCJtVAFtOzFX1f6czxAOesKBfBbSUacttJiAXMms2FMniiPgo7Dwgn5Y0gvKcoptQw0bjOftp0qAA21uoaRmU_bs9C7q1e1ET7AY7WcbS8b'
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
      ),
    );
  }
}
