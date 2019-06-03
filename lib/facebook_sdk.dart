import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FacebookSdk {
  static const MethodChannel _channel = const MethodChannel('facebook_sdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('event');
    return version;
  }

  static Future<void> initFacebookSdk({@required String appId}) async {
    _channel.invokeMethod('init', {
      "appId": appId,
    });
  }

  static Future<void> logEventFacebook({@required String eventName}) async {
    await _channel.invokeMethod('event', {
      "eventName": eventName,
    });
  }
}
