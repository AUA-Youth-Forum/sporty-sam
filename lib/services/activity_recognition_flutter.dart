library activity_recognition;

import 'dart:async';
import 'package:flutter/services.dart';

part 'ar_domain.dart';

/// Main entry to activity recognition API. Use as a singleton like
///
///   `ActivityRecognition.instance`
///
class ActivityRecognition {
  Stream<ActivityEvent>? _stream;

  ActivityRecognition._();

  static final ActivityRecognition _instance = ActivityRecognition._();

  static ActivityRecognition get instance => _instance;

  static const EventChannel _eventChannel =
      const EventChannel('activity_recognition_flutter');

  /// Requests continuous [ActivityEvent] updates.
  ///
  /// The Stream will output the *most probable* [ActivityEvent].
  /// By default the foreground service is enabled, which allows the
  /// updates to be streamed while the app runs in the background.
  /// The programmer can choose to not enable to foreground service.
  Stream<ActivityEvent> startStream({bool runForegroundService = true}) {
    if (_stream == null) {
      _stream = _eventChannel
          .receiveBroadcastStream({"foreground": runForegroundService}).map(
              (json) => ActivityEvent.fromJson(json));
    }
    return _stream!;
  }
}
