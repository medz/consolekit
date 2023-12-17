import '../console.dart';
import 'console_clear.dart';

extension ConsoleClearLines on Console {
  /// Deletes lines that were previously printed to the console.
  ///
  ///   console.clearLines(3);
  ///
  /// This will delete the last 3 lines that were printed to the console.
  void clearLines(int count) {
    for (int _ = 0; _ < count; _++) {
      clear(ConsoleClear.line);
    }
  }
}
