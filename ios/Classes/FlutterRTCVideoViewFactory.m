#import "FlutterRTCVideoViewFactory.h"
#import "WebRTC/RTCEAGLVideoView.h"
#import <Flutter/FlutterPlatformViews.h>
#import <Flutter/Flutter.h>
#import <WebRTC/RTCMediaStream.h>
#import <WebRTC/RTCVideoTrack.h>
#import <WebRTC/RTCMTLVideoView.h>
#import "FlutterRTCVideoView.h"


@implementation FlutterWebRTCPlugin (FlutterPlatformViewFactory)

- (NSObject <FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    NSString *streamId = args;
    RTCMediaStream *stream = [self streamForId:streamId];
    RTCEAGLVideoView *vv = [[RTCEAGLVideoView alloc] initWithFrame:CGRectZero];
    FlutterEventChannel *eventChannel = [FlutterEventChannel
            eventChannelWithName:[NSString stringWithFormat:@"cloudwebrtc.com/WebRTC/PlatformView%lld", viewId]
                 binaryMessenger:self.messenger];
    RTCVideoTrack *videoTrack = stream.videoTracks[0];
    [videoTrack addRenderer:vv];
    return [[FlutterRTCVideoView alloc] initWithView:vv eventChannel: eventChannel];
}

- (NSObject <FlutterMessageCodec> *)createArgsCodec {
    return FlutterStandardMessageCodec.sharedInstance;
}

@end
