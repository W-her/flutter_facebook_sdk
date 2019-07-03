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

  static Future<void> logEvent({
    @required String eventName,
    Map<String, dynamic> params,
  }) async {
    await _channel.invokeMethod('logEvent', {
      "eventName": eventName,
      "params": params,
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

  static Future<void> updateUserProperties({
    @required Map<String, dynamic> params,
  }) async {
    await _channel.invokeMethod('updateUserProperties', {
      "params": params,
    });
  }

  static Future<void> standardEvent(StandardEvent standardEvent) async {
    switch (standardEvent) {
      case StandardEvent.EVENT_NAME_SUBSCRIBE:
        await _channel.invokeMethod('standardEventSubscribe');
        break;
      case StandardEvent.EVENT_NAME_SEARCHED:
        await _channel.invokeMethod('standardEventSearched');
        break;
      case StandardEvent.EVENT_NAME_RATED:
        await _channel.invokeMethod('standardEventRated');
        break;
      default:
    }
  }
}

enum StandardEvent {
  EVENT_NAME_SUBSCRIBE,
  EVENT_NAME_SEARCHED,
  EVENT_NAME_RATED
}
