import '../console.dart';
import '../output/console_style.dart';
import '../output/console_text.dart';
import 'activity_bar.dart';
import 'activity_indicator.dart';

/// Loading-style implementation of [ActivityBar].
///
/// ```
/// Loading [        •             ]
/// ```
///
/// The `•` character will bounce from left to right while the bar is active.
class LoadingBar extends ActivityBar {
  LoadingBar({super.title, super.failure, super.success});

  @override
  ConsoleText renderActiveBar(int tick, int width) {
    final period = width - 1;
    final offset = tick % period;
    final reverse = tick % (period * 2) >= period;
    final decreasing = width - offset - 1;
    final (letf, right) = reverse ? (decreasing, offset) : (offset, decreasing);

    return ['[', ' ' * letf, '•', ' ' * right, ']']
        .join()
        .consoleText(style: ConsoleStyle.info);
  }
}

extension CreateLoadingBarIndicator on Console {
  /// Create a loading-style activity indicator.
  ///
  /// ```
  /// Loading [        •             ]
  /// ```
  ///
  /// The `•` character will bounce from left to right while the bar is active.
  ///
  /// ```dart
  /// final indicator = console.createLoadingBarIndicator();
  ///
  /// // Start the indicator
  /// indicator.start();
  ///
  /// // Stop the indicator
  /// await Future.delayed(Duration(seconds: 3));
  /// indicator.stop();
  /// ```
  ActivityIndicator<LoadingBar> createLoadingBarIndicator({
    String? title,
    String failure = '✗',
    String success = '✓',
  }) =>
      ActivityIndicator(
        activity: LoadingBar(
          title: title,
          failure: failure,
          success: success,
        ),
        console: this,
      );
}
