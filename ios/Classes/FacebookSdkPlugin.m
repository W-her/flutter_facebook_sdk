#import "FacebookSdkPlugin.h"
#import <facebook_sdk/facebook_sdk-Swift.h>

@implementation FacebookSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFacebookSdkPlugin registerWithRegistrar:registrar];
}
@end
