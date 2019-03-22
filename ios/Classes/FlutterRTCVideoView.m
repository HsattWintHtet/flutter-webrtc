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
    if (self.size.width != size.width
        && self.size.height != size.height) {
        [self.videoView setSize:size];
        NSDictionary *event = @{
            @"event": @"didChangeVideoSize",
            @"width": @(size.width),
            @"height": @(size.height)
        };
        for (FlutterEventSink sink in self.eventSinks) {
            if (sink)
                sink(event);
        }
        self.size = size;
    }
}

- (FlutterError *_Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(FlutterEventSink)events {
    [self.eventSinks addObject:events];
    if (self.size.width != 0 && self.size.height != 0) {
        NSDictionary *event = @{
            @"event": @"didChangeVideoSize",
            @"width": @(self.size.width),
            @"height": @(self.size.height)
        };
        events(event);
    }
    return nil;
}

- (FlutterError *_Nullable)onCancelWithArguments:(id _Nullable)arguments {
    [self.eventSinks removeAllObjects];
    return nil;
}

@end
