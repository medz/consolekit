import '../console.dart';
import '../output/console_style.dart';
import '../output/console_text.dart';
import 'activity_indicator.dart';

abstract class ActivityBar implements ActivityIndicatorRenderer {
  /// Returns or sets the title of the activity bar.
  String? title;

  final String success;
  final String failure;

  ActivityBar({
    this.title,
    this.success = '✓',
    this.failure = '✗',
  });

  /// Called each time the `ActivityBar` should refresh its display.
  ConsoleText renderActiveBar(int tick, int width);

  @override
  void render(Console console, ActivityIndicatorState state) {
    final bar = switch (state) {
      ActivityIndicatorState(isReady: true) => '[]'.consoleText(),
      ActivityIndicatorState(isSuccess: true) =>
        success.consoleText(style: ConsoleStyle.success),
      ActivityIndicatorState(isFailure: true) =>
        failure.consoleText(style: ConsoleStyle.error),
      ActivityIndicatorState(isActive: true, tick: final tick) =>
        renderActiveBar(tick, console.activityBarWidth),
      _ => throw StateError('The activity indicator is not active.'),
    };
    final title = this.title?.consoleText();
    final text = title == null ? bar : title + ' '.consoleText() + bar;

    console.output(text, newline: true);
  }
}

extension ActivityBarWidth on Console {
  /// Returns current configured width of the console.
  ///
  /// Defaults to 25.
  int get activityBarWidth =>
      switch (userinfo[#consolekit.terminal.activity.activity_bar.width]) {
        int width => width,
        _ => activityBarWidth = 25
      };

  /// Sets the width of the activity bar.
  set activityBarWidth(int width) =>
      userinfo[#consolekit.terminal.activity.activity_bar.width] = width;
}
