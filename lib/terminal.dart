import 'dart:convert';
import 'dart:io';

import 'src/ansi.dart';
import 'src/clear/console_clear.dart';
import 'src/clear/console_ephemeral.dart';
import 'src/console.dart';
import 'src/output/console_text.dart';

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
    didOutputLines(1);
    stdin.echoMode = !secure;
    return stdin.readLineSync() ?? '';
  }

  @override
  void output(ConsoleText text, {bool newline = true}) {
    void write(String text) {
      final lines = const LineSplitter().convert(text);
      if (lines.isEmpty) return;

      final last = lines.removeLast();
      for (final line in lines) {
        didOutputLines(1);
        stdout.writeln(line);
      }

      didOutputLines(1);
      newline ? stdout.writeln(last) : stdout.write(last);
    }

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
