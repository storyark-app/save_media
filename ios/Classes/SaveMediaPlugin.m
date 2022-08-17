#import "SaveMediaPlugin.h"
#if __has_include(<save_media/save_media-Swift.h>)
#import <save_media/save_media-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "save_media-Swift.h"
#endif

@implementation SaveMediaPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSaveMediaPlugin registerWithRegistrar:registrar];
}
@end
