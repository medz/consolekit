import 'dart:io' as io;

import 'ansi.dart';
import 'clear/console_clear.dart';
import 'console.dart';
import 'output/console_text.dart';

class Terminal implements Console {
  final io.Stdout stdout;
  final io.Stdout stderr;
  final io.Stdin stdin;

  Terminal.std({
    required this.stdout,
    required this.stderr,
    required this.stdin,
  });

  factory Terminal() =>
      Terminal.std(stdout: io.stdout, stderr: io.stderr, stdin: io.stdin);

  /// Performs an `ANSICommand`.
  void command(ANSICommand command) => stdout.write(command.ansi);

  @override
  void clear({ConsoleClear? type, int? lines}) {
    // TODO: implement clear
  }

  @override
  String input({bool secure = false}) {
    // TODO: implement input
    throw UnimplementedError();
  }

  @override
  void output(ConsoleText text, {bool newline = true}) {
    // TODO: implement output
  }

  @override
  void report(String error, {bool newline = true}) {
    // TODO: implement report
  }

  @override
  (int, int) get size => throw UnimplementedError();

  @override
  final Map userinfo = {};
}
