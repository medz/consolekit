import 'clear/console_clear.dart';
import 'output/console_text.dart';

abstract interface class Console {
  /// The size of the [Console] window. Used for calculating lines printed
  /// and centering text.
  (int width, int height) get size;

  /// Returns a [String] of input read from the [Console] until a line feed
  /// character was found.
  ///
  ///     final input = console.input(secure: false);
  ///     print('You typed: $input');
  ///
  /// If [secure] is `true`, the input will not be echoed to the console.
  String input({bool secure = false});

  /// Outputs serialized [ConsoleText] to the [Console].
  ///
  ///     console.output("Hello, World!".consoleText(
  ///       color: ConsoleColor.green
  ///     ));
  ///
  /// If [newline] is `true`, a line feed character will be appended to the
  /// output.
  void output(ConsoleText text, {bool newline = true});

  /// Clears previously printed [Console] output according to the [ConsoleClear]
  /// type specified.
  void clear(ConsoleClear type);

  /// Outputs an error to the [Console]'s error stream.
  void report(ConsoleText text, {bool newline = true});

  /// The current user's information.
  abstract final Map userinfo;
}
