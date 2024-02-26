import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

/// [DynamicLinkService]
class DynamicLinkService {
  static final DynamicLinkService _singleton = DynamicLinkService._internal();

  DynamicLinkService._internal();

  static DynamicLinkService get instance => _singleton;

  // Create new dynamic link
  Future<void> createDynamicLink() async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://naimulhassan.000webhostapp.com/"),
      uriPrefix: "https://naimulhassan.000webhostapp.com",
      androidParameters:
          const AndroidParameters(packageName: "com.example.push_notification"),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    debugPrint("shortUrl ===========================> ${dynamicLink.shortUrl}");
  }
}
