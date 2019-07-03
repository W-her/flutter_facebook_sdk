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
    FacebookSdk.setApplicationId(appId: "207820050055545");
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: RaisedButton(
                child: Text("logEvent"),
                onPressed: () {
                  FacebookSdk.logEvent(
                    eventName: "FlutterFacebookSdkEvent",
                    params: {"event": "eventParam"},
                  );
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text("setUserID"),
                onPressed: () {
                  FacebookSdk.setUserID(userID: "1234");
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text("clearUserID"),
                onPressed: () {
                  FacebookSdk.clearUserID();
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text("updateUserProperties"),
                onPressed: () {
                  FacebookSdk.updateUserProperties(
                    params: {"property": "userParam"},
                  );
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text("Standard Event Subscribe"),
                onPressed: () {
                  FacebookSdk.standardEvent(
                    StandardEvent.EVENT_NAME_SUBSCRIBE,
                  );
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text("Standard Event Searched"),
                onPressed: () {
                  FacebookSdk.standardEvent(
                    StandardEvent.EVENT_NAME_SEARCHED,
                  );
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text("Standard Event Rated"),
                onPressed: () {
                  FacebookSdk.standardEvent(
                    StandardEvent.EVENT_NAME_RATED,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
