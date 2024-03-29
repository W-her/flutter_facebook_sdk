package it.wher.facebook_sdk;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import com.facebook.FacebookSdk;
import com.facebook.appevents.AppEventsConstants;
import com.facebook.appevents.AppEventsLogger;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FacebookSdkPlugin
 */
public class FacebookSdkPlugin implements MethodCallHandler {
    private AppEventsLogger logger;
    private Context context;

    private FacebookSdkPlugin(Registrar registrar) {
        context = registrar.context();

    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "facebook_sdk");
        channel.setMethodCallHandler(new FacebookSdkPlugin(registrar));
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case "setApplicationId": {
                String appId = call.argument("appId");
                FacebookSdk.setApplicationId(appId);
                FacebookSdk.sdkInitialize(context);
                logger = AppEventsLogger.newLogger(context);
                result.success(null);
                break;
            }
            case "logEvent": {
                Map options = (Map<?, ?>) call.arguments;
                String eventName = (String) options.get("eventName");
                Map<String, String> params = (Map<String, String>) options.get("params");
                if (params != null) {
                    Bundle bundle = new Bundle();
                    for (Map.Entry<String, String> entry : params.entrySet()) {
                        bundle.putString(entry.getKey(), entry.getValue());
                    }
                    logger.logEvent(eventName, bundle);
                } else {
                    logger.logEvent(eventName);
                }
                result.success(null);
                break;
            }
            case "setUserID": {
                String userID = call.argument("userID");
                logger.setUserID(userID);
                result.success(null);
                break;
            }
            case "clearUserID": {
                logger.clearUserID();
                result.success(null);
                break;
            }
            case "updateUserProperties": {
                Map options = (Map<?, ?>) call.arguments;
                Map<String, String> params = (Map<String, String>) options.get("params");
                Bundle bundle = new Bundle();
                for (Map.Entry<String, String> entry : params.entrySet()) {
                    bundle.putString(entry.getKey(), entry.getValue());
                }
                logger.updateUserProperties(bundle, null);
                result.success(null);
                break;
            }
            case "standardEventSubscribe": {
                logger.logEvent(AppEventsConstants.EVENT_NAME_SUBMIT_APPLICATION);
                result.success(null);
                break;
            }
            case "standardEventSearched": {
                logger.logEvent(AppEventsConstants.EVENT_NAME_SEARCHED);
                result.success(null);
                break;
            }
            case "standardEventRated": {
                logger.logEvent(AppEventsConstants.EVENT_NAME_RATED);
                result.success(null);
                break;
            }
            default:
                result.notImplemented();
                break;
        }
    }
}
