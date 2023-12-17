import 'dart:async';

import '../console.dart';
import '../clear/console_ephemeral.dart';

class ActivityIndicatorState {
  /// State internal value:
  ///
  /// - `-1`: ready
  /// - `-2`: success
  /// - `-3`: failure
  /// - `>= 0`: active, the value is the active tick.
  final int _interval;

  const ActivityIndicatorState._(this._interval);

  /// The activity indicator is ready.
  static const ready = ActivityIndicatorState._(-1);

  /// The activity indicator is active.
  factory ActivityIndicatorState.active(int tick) {
    if (tick < 0) {
      throw ArgumentError.value(tick, 'tick', 'must be non-negative');
    }
    return ActivityIndicatorState._(tick);
  }

  /// The activity indicator is success.
  static const success = ActivityIndicatorState._(-2);

  /// The activity indicator is failure.
  static const failure = ActivityIndicatorState._(-3);

  /// Whether the activity indicator is ready.
  bool get isReady => _interval == -1;

  /// Whether the activity indicator is active.
  bool get isActive => _interval >= 0;

  /// Whether the activity indicator is success.
  bool get isSuccess => _interval == -2;

  /// Whether the activity indicator is failure.
  bool get isFailure => _interval == -3;

  /// The active tick.
  int get tick => switch (this) {
        ActivityIndicatorState(isActive: true, _interval: final tick) => tick,
        _ => throw StateError('The activity indicator is not active.'),
      };
}

abstract interface class ActivityIndicatorRenderer {
  /// Render the activity indicator.
  ///
  /// The [state] is the current state of the activity indicator.
  ///
  /// The [buffer] is the buffer to render the activity indicator.
  void render(Console console, ActivityIndicatorState state);
}

class ActivityIndicator<T extends ActivityIndicatorRenderer> {
  final T activity;
  final Console _console;
  Timer? _timer;

  ActivityIndicator({
    required this.activity,
    required Console console,
  }) : _console = console;

  /// Starts the activity indicator.
  ///
  /// The [interval] is the interval of the activity indicator.
  void start(Duration interval) {
    if (_timer != null) {
      throw StateError('The activity indicator is already started.');
    }

    activity.render(_console, ActivityIndicatorState.ready);
    _timer = Timer.periodic(interval, (timer) {
      if (timer.tick > 0) {
        _console.unephemeral();
      }

      _console.ephemeral();
      activity.render(_console, ActivityIndicatorState.active(timer.tick));
    });
  }

  /// Stops the activity indicator with success.
  void success() {
    _stop();
    activity.render(_console, ActivityIndicatorState.success);
  }

  /// Stops the activity indicator with failure.
  void failure() {
    _stop();
    activity.render(_console, ActivityIndicatorState.failure);
  }

  /// Stops the activity indicator.
  void _stop() {
    if (_timer == null) return;
    if (_timer!.tick > 0) {
      _console.unephemeral();
    }

    _timer?.cancel();
    _timer = null;
  }
}
