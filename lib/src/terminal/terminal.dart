import 'dart:io';

import 'ansi.dart';
import 'clear/console_clear.dart';
import 'console.dart';
import 'output/console_text.dart';

class Terminal implements Console {
  Terminal();

  /// Performs an `ANSICommand`.
  void command(ANSICommand command) => stdout.write(command.ansi);

  @override
  void clear(ConsoleClear type) {
    switch (type) {
      case ConsoleClear.line:
        command(ANSICommand.cursorUp);
        command(ANSICommand.eraseLine);
        break;
      case ConsoleClear.screen:
        command(ANSICommand.eraseScreen);
        break;
    }
  }

  @override
  String input({bool secure = false}) {
    stdin.echoMode = !secure;
    return stdin.readLineSync() ?? '';
  }

  @override
  void output(ConsoleText text, {bool newline = true}) {
    void write(String text) =>
        newline ? stdout.writeln(text) : stdout.write(text);
    final output =
        stylizedOutputOverride ? text.terminalStylize() : text.toString();

    return write(output);
  }

  @override
  void report(ConsoleText text, {bool newline = true}) {
    void write(String text) =>
        newline ? stderr.writeln(text) : stderr.write(text);
    final output =
        stylizedOutputOverride ? text.terminalStylize() : text.toString();

    return write(output);
  }

  @override
  (int, int) get size => (stdout.terminalColumns, stdout.terminalLines);

  @override
  final Map userinfo = {};
}

extension StylizedOutputOverride on Console {
  /// Returns stylized [ConsoleText] output for the [Console].
  bool get stylizedOutputOverride =>
      switch (userinfo['stylizedOutputOverride']) {
        bool override => override,
        _ => stdout.supportsAnsiEscapes,
      };

  /// Sets stylized [ConsoleText] output for the [Console].
  set stylizedOutputOverride(bool override) =>
      userinfo['stylizedOutputOverride'] = override;
}
