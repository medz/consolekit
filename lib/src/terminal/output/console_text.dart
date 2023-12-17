import 'dart:collection';

import 'console_color.dart';
import 'console_style.dart';

/// A single piece of [ConsoleText]. Contains a raw [String] and the
/// desired [ConsoleStyle].
class ConsoleTextFragment {
  /// The raw text to be outputted.
  final String text;

  /// The style to be applied to the text.
  final ConsoleStyle style;

  /// Creates a new [ConsoleTextFragment] with the given [text] and [style].
  const ConsoleTextFragment(this.text, [this.style = ConsoleStyle.plain]);
}

/// A collection of [ConsoleTextFragment]s. Represents stylized text that can
/// be outputted to a [Console].
class ConsoleText
    with ListBase<ConsoleTextFragment>
    implements List<ConsoleTextFragment> {
  final List<ConsoleTextFragment> _fragments;

  /// Creates a new [ConsoleText].
  const ConsoleText.fragment([List<ConsoleTextFragment>? fragments])
      : _fragments = fragments ?? const [];

  /// Creates a new [ConsoleText] from the given [text] and [style].
  factory ConsoleText(String text, [ConsoleStyle style = ConsoleStyle.plain]) {
    final fragment = ConsoleTextFragment(text, style);
    return ConsoleText.fragment([fragment]);
  }

  @override
  int get length => _fragments.length;

  @override
  set length(int newLength) => _fragments.length = newLength;

  @override
  ConsoleTextFragment operator [](int index) => _fragments[index];

  @override
  void operator []=(int index, ConsoleTextFragment value) =>
      _fragments[index] = value;

  @override
  String toString() => _fragments.map((f) => f.text).join();
}

extension ConsoleTextHelpers on String {
  ConsoleText consoleText({
    ConsoleColor? color,
    ConsoleColor? background,
    bool bold = false,
    ConsoleStyle? style,
  }) {
    final resolvedStyle = switch (style) {
      ConsoleStyle style => style,
      _ => ConsoleStyle(color: color, background: background, bold: bold),
    };

    return ConsoleText(this, resolvedStyle);
  }
}
