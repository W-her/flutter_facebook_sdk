import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FacebookSdk {
  static const MethodChannel _channel = const MethodChannel('facebook_sdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('event');
    return version;
  }

  static Future<void> setApplicationId({@required String appId}) async {
    _channel.invokeMethod('setApplicationId', {
      "appId": appId,
    });
  }

  static Future<void> logEvent({@required String eventName}) async {
    await _channel.invokeMethod('logEvent', {
      "eventName": eventName,
    });
  }

  static Future<void> setUserID({@required String userID}) async {
    await _channel.invokeMethod('setUserID', {
      "userID": userID,
    });
  }

  static Future<void> clearUserID() async {
    await _channel.invokeMethod('clearUserID');
  }
}
