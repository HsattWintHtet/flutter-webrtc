#import <Flutter/Flutter.h>
#import "FlutterRTCVideoView.h"


@implementation FlutterRTCVideoView {

}
- (instancetype)initWithView:(RTCEAGLVideoView *)view eventChannel:(FlutterEventChannel *)channel {
    self.videoView = view;
    self.eventSinks = [[NSMutableSet alloc] init];
    [channel setStreamHandler:self];
    view.delegate = self;
    return self;
}

- (UIView *)view {
    return self.videoView;
}

- (void)videoView:(id <RTCVideoRenderer>)videoView didChangeVideoSize:(CGSize)size {
    self.size = size;
    [self.videoView setSize:size];
//    self.videoView.frame = CGRectMake(0, 0, size.width, size.height);
    NSDictionary *event = @{
        @"width": @(size.width),
        @"height": @(size.height)
    };
    for (FlutterEventSink sink in self.eventSinks) {
        if (sink)
            sink(event);
    }
}

- (FlutterError *_Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(FlutterEventSink)events {
    [self.eventSinks addObject:events];
    if (self.size.width != 0 && self.size.height != 0) {
        NSDictionary *event = @{
            @"width": @(self.size.width),
            @"height": @(self.size.height)
        };
        events(event);
    }
    return nil;
}

- (FlutterError *_Nullable)onCancelWithArguments:(id _Nullable)arguments {
    return nil;
}


@end