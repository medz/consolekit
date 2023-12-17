import '../console.dart';
import '../output/console_style.dart';
import '../output/console_text.dart';
import 'activity_bar.dart';
import 'activity_indicator.dart';

/// An activity indicator with customizable frames and success and failure
/// messages.
class CustomActivityBar extends ActivityBar {
  /// The default frames used by the [CustomActivityBar].
  static final defaultFrames = <String>[
    "⠋",
    "⠙",
    "⠹",
    "⠸",
    "⠼",
    "⠴",
    "⠦",
    "⠧",
    "⠇",
    "⠏"
  ].map((frame) => frame.consoleText()).toList();

  /// The text that will be output on the indicator ticks, each frame
  /// corresponding to a single tick in a range of `0...(frames.count - 1)`.
  final List<ConsoleText> frames;

  const CustomActivityBar({
    super.title,
    super.success,
    super.failure,
    required this.frames,
  });

  @override
  ConsoleText renderActiveBar(int tick, int width) {
    final frames = this.frames.isNotEmpty ? this.frames : defaultFrames;

    return frames[tick % frames.length];
  }

  @override
  void render(Console console, ActivityIndicatorState state) {
    final frame = switch (state) {
      ActivityIndicatorState(isSuccess: true) =>
        success.consoleText(style: ConsoleStyle.success),
      ActivityIndicatorState(isFailure: true) =>
        failure.consoleText(style: ConsoleStyle.error),
      ActivityIndicatorState(isActive: true, tick: final tick) =>
        renderActiveBar(tick, console.activityBarWidth),
      _ => renderActiveBar(0, console.activityBarWidth),
    };

    final title = this.title?.consoleText();
    final text = title == null ? frame : title + ' '.consoleText() + frame;

    console.output(text, newline: true);
  }
}

extension CreateCustomActivityBarIndicator on Console {
  /// Creates a new [ActivityIndicator] with customizable frames and success and
  /// failure messages.
  ActivityIndicator<CustomActivityBar> createActivity({
    String? title,
    List<ConsoleText> frames = const [],
    String success = '✓',
    String failure = '✗',
  }) {
    final bar = CustomActivityBar(
      title: title,
      frames: frames,
      success: success,
      failure: failure,
    );

    return ActivityIndicator(activity: bar, console: this);
  }
}
