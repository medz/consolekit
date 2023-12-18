import '../console.dart';
import '../output/console_style.dart';
import '../output/console_text.dart';
import 'activity_bar.dart';
import 'activity_indicator.dart';

/// Progress-style implementation of [ActivityBar].
///
/// ```
/// Downloading [========                ]
/// ```
///
/// The progress bar is updated by calling `progress = 0.5` to set the progress
/// to 50%.
class ProgressBar extends ActivityBar {
  ProgressBar({super.title, super.success, super.failure});

  double _progress = 0.0;

  /// Returns or sets the progress of the progress bar.
  double get progress => _progress;

  /// Sets the progress of the progress bar.
  set progress(double progress) {
    _progress = progress.clamp(0.0, 1.0);
  }

  @override
  ConsoleText renderActiveBar(int tick, int width) {
    final left = (width * progress).floor();
    final right = width - left;

    return ['[', '=' * left, ' ' * right, ']']
        .join()
        .consoleText(style: ConsoleStyle.info);
  }
}

extension CreateProgressBar on Console {
  /// Creates a new [ProgressBar].
  ActivityIndicator<ProgressBar> createProgressBar({
    String? title,
    String success = '✓',
    String failure = '✗',
  }) =>
      ActivityIndicator(
        activity: ProgressBar(
          title: title,
          success: success,
          failure: failure,
        ),
        console: this,
      );
}
