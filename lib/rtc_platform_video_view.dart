import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'media_stream.dart';

class RTCPlatformVideoView extends StatefulWidget {
	final MediaStream _stream;

  const RTCPlatformVideoView(this._stream, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RTCPlatformVideoState(_stream);
  }
}

class RTCPlatformVideoState extends State<RTCPlatformVideoView> {
	final MediaStream _stream;
	int _platformId;
	double _width = 0, _height = 0;
	StreamSubscription<dynamic> _eventSubscription;

  RTCPlatformVideoState(this._stream);

	double get aspectRatio =>
			_width == 0 || _height == 0 ? 1 : _width / _height;

	double get width => _width;

	double get height => _height;

	@override
	Widget build(BuildContext context) {
		assert(Platform.isIOS);
		assert(_stream != null);
		return AspectRatio(
			aspectRatio: aspectRatio,
			child: UiKitView(
				viewType: "FlutterRTCVideoView",
				creationParams: _stream.id,
				creationParamsCodec: StandardMessageCodec(),
				onPlatformViewCreated: _onCreated,
			)
		);
	}

	void _onCreated(int id) {
		if (_eventSubscription != null)
			return;
		_platformId = id;
		_eventSubscription = EventChannel('cloudwebrtc.com/WebRTC/PlatformView$id')
				.receiveBroadcastStream()
				.listen((event) {
					print(event);
					setState(() {
					  _width = event['width'];
					  _height = event['height'];
					});
				});
	}

	@override
  void dispose() {
		_eventSubscription?.cancel();
    super.dispose();
  }

}