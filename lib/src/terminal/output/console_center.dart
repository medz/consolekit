import 'dart:convert';
import 'dart:math';

import '../console.dart';

extension ConsoleCenter on Console {
  /// Centers a [String] according to this console's [size].
  String center(String text, {String padding = " "}) {
    return const LineSplitter()
        .convert(text)
        .center(width: size.$1, padding: padding)
        .join('\n');
  }

  /// Centers a iterable of [String] according to this console's [size].
  Iterable<String> centerLines(Iterable<String> lines,
          {String padding = " "}) =>
      lines.center(width: size.$1, padding: padding);
}

extension on Iterable<String> {
  /// Centers a [String] according to this console's [size].
  Iterable<String> center({String padding = " ", required int width}) {
    final lines = map((e) => const LineSplitter().convert(e)).expand((e) => e);
    final longest = lines.map((e) => e.length).reduce(max);
    final count = max(0, (width - longest) ~/ 2);

    // Apply the padding to each line
    return lines.map((e) => padding * count + e);
  }
}
