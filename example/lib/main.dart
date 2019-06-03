import 'package:flutter/material.dart';
import 'package:facebook_sdk/facebook_sdk.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FacebookSdk.setApplicationId(appId: [FACEBOOKAPPIDHERE]);
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Plugin example app'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              FacebookSdk.logEvent(eventName: "FlutterFacebookSdkEvent");
            },
          ),
        ),
      ),
    );
  }
}
