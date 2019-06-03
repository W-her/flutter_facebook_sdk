package it.wher.facebook_sdk;

import android.app.Activity;
import android.content.Context;
import android.util.Log;

import com.facebook.FacebookSdk;
import com.facebook.appevents.AppEventsLogger;

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
            case "init": {
                String appId = call.argument("appId");
                FacebookSdk.setApplicationId(appId);
                FacebookSdk.sdkInitialize(context);
                logger = AppEventsLogger.newLogger(context);
                break;
            }
            case "event": {
                String eventName = call.argument("eventName");
                logger.logEvent(eventName);
                break;
            }
            default:
                result.notImplemented();
                break;
        }
    }
}
