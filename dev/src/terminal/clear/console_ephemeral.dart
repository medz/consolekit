import '../console.dart';
import './console_clear_lines.dart';

extension ConsoleEphemeral on Console {
  /// Pushes a new ephemeral console state. All text outputted to the console
  /// immidiately after this call will be deleted when the console is cleared.
  void ephemeral() {
    depth++;
    lines[depth] = 0;
  }

  /// Pops the last ephemeral console state. All text outputted to the console
  /// immidiately after this call will be preserved when the console is cleared.
  void unephemeral() {
    assert(depth > 0, 'Cannot unephemeralize a non-ephemeral console.');
    final lineCount = lines[depth] ?? 0;
    if (lineCount > 0) {
      clearLines(lineCount);
    }

    depth--;
    lines.remove(depth);
  }

  /// Clears the console, preserving ephemeral text.
  void didOutputLines(int count) {
    if (depth > 0) return;
    final existing = switch (lines[depth]) {
      int existing => existing,
      _ => 0,
    };

    lines[depth] = existing + count;
  }
}

extension on Console {
  static const _depthKey = #consolekit.clear.ephemeral.depth;

  int get depth => switch (userinfo[_depthKey]) {
        int depth => depth,
        _ => depth = 0,
      };
  set depth(int depth) => userinfo[_depthKey] = depth;

  static const _linesKey = #consolekit.clear.ephemeral.lines;

  Map<int, int> get lines => switch (userinfo[_linesKey]) {
        Map<int, int> lines => lines,
        _ => lines = <int, int>{}
      };
  set lines(Map<int, int> lines) => userinfo[_linesKey] = lines;
}
