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
            Settings.appID = appId
        }
    case "logEvent":
        if let args = call.arguments as? [String: Any], let eventName = args["eventName"] as? String {
            if let params = args["params"] as? [String: String] {
                AppEvents.logEvent(AppEvents.Name(rawValue: eventName), parameters: params)
            } else {
                AppEvents.logEvent(AppEvents.Name(rawValue: eventName))
            }
        }
    case "setUserID":
        if let args = call.arguments as? [String: Any], let userID = args["userID"] as? String {
            AppEvents.userID = userID
        }
    case "clearUserID":
        AppEvents.clearUserID()
    case "updateUserProperties":
        if let args = call.arguments as? [String: Any], let params = args["params"] as? [String: String] {
            AppEvents.updateUserProperties(params, handler: nil)
        }
    case "standardEventSubscribe":
        AppEvents.logEvent(AppEvents.Name.submitApplication)
    case "standardEventSearched":
        AppEvents.logEvent(AppEvents.Name.searched)
    case "standardEventRated":
        AppEvents.logEvent(AppEvents.Name.rated)
    default:
        result(FlutterMethodNotImplemented)
    }
  }
}
