import '../console.dart';
import 'console_style.dart';
import 'console_text.dart';

extension ConsoleOutput on Console {
  void write(
    String text, {
    bool newline = true,
    ConsoleStyle style = ConsoleStyle.plain,
  }) =>
      output(ConsoleText(text, style), newline: newline);

  /// Outputs a newline to the console.
  void newline() => write(' ', newline: true);

  /// Outputs a [String] to the console with [ConsoleStyle.plain].
  void plain(String text, {bool newline = true}) =>
      write(text, newline: newline, style: ConsoleStyle.plain);

  /// Outputs a [String] to the console with [ConsoleStyle.success].
  void success(String text, {bool newline = true}) =>
      write(text, newline: newline, style: ConsoleStyle.success);

  /// Outputs a [String] to the console with [ConsoleStyle.info].
  void info(String text, {bool newline = true}) =>
      write(text, newline: newline, style: ConsoleStyle.info);

  /// Outputs a [String] to the console with [ConsoleStyle.warning].
  void warning(String text, {bool newline = true}) =>
      write(text, newline: newline, style: ConsoleStyle.warning);

  /// Outputs a [String] to the console with [ConsoleStyle.error].
  void error(String text, {bool newline = true}) =>
      write(text, newline: newline, style: ConsoleStyle.error);
}
