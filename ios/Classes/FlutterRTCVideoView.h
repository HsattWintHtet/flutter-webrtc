#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "WebRTC/RTCMTLVideoView.h"
#import "WebRTC/RTCEAGLVideoView.h"
#import "Flutter/FlutterChannels.h"

@class FlutterEventChannel;

@interface FlutterRTCVideoView : NSObject<FlutterPlatformView, RTCVideoViewDelegate, FlutterStreamHandler>

@property (strong, nonatomic) RTCEAGLVideoView *videoView;
@property (strong, nonatomic) NSMutableSet<FlutterEventSink> *eventSinks;
@property (nonatomic) CGSize size;

- (instancetype)initWithView:(RTCEAGLVideoView *)view
                eventChannel:(FlutterEventChannel *)channel;

@end