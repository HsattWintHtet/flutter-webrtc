#import <Foundation/Foundation.h>
#import <Flutter/FlutterPlatformViews.h>
#import "FlutterWebRTCPlugin.h"

@interface FlutterWebRTCPlugin (FlutterPlatformViewFactory)

- (NSObject <FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                     viewIdentifier:(int64_t)viewId
                                          arguments:(id _Nullable)args;

- (NSObject <FlutterMessageCodec> *)createArgsCodec;

@end