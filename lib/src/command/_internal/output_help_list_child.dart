import 'dart:convert';

import '../../console.dart';
import '../../output/console_output.dart';
import '../../output/console_style.dart';
import '../../output/console_text.dart';

extension OutputHelpListChind on Console {
  void outputHelpListChind(
    String name, {
    String? help,
    required ConsoleStyle style,
    required int padding,
  }) {
    output('${' ' * padding}$name'.consoleText(style: style), newline: false);

    final lines = const LineSplitter().convert(help ?? '');
    if (lines.isEmpty) {
      return plain(' n/a');
    }

    plain(' ${lines.first}');
    for (final line in lines.skip(1)) {
      plain('${' ' * padding}$line');
    }
  }
}
