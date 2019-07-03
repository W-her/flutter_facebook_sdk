import Flutter
import UIKit
import FBSDKCoreKit

public class SwiftFacebookSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "facebook_sdk", binaryMessenger: registrar.messenger())
    let instance = SwiftFacebookSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    //Settings.enableLoggingBehavior(LoggingBehavior.appEvents)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "setApplicationId":
        if let args = call.arguments as? [String: Any], let appId = args["appId"] as? String {
            FBSDKSettings.setAppID(appId)
        }
    case "logEvent":
        if let args = call.arguments as? [String: Any], let eventName = args["eventName"] as? String {
            if let params = args["params"] as? [String: String] {
                FBSDKAppEvents.logEvent(eventName, parameters: params)
            } else {
                FBSDKAppEvents.logEvent(eventName)
            }
        }
    case "setUserID":
        if let args = call.arguments as? [String: Any], let userID = args["userID"] as? String {
            FBSDKAppEvents.setUserID(userID)
        }
    case "clearUserID":
        FBSDKAppEvents.clearUserID()
    case "updateUserProperties":
        if let args = call.arguments as? [String: Any], let params = args["params"] as? [String: String] {
            FBSDKAppEvents.updateUserProperties(params, handler: nil)
        }
    case "standardEventSubscribe":
        FBSDKAppEvents.logEvent(FBSDKAppEventNameSubmitApplication)
    case "standardEventSearched":
        FBSDKAppEvents.logEvent(FBSDKAppEventNameSearched)
    case "standardEventRated":
        FBSDKAppEvents.logEvent(FBSDKAppEventNameRated)
    default:
        result(FlutterMethodNotImplemented)
    }
  }
}
