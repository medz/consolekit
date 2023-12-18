import 'dart:io';

import '../console.dart';
import '../output/console_text.dart';

extension ConsoleASK on Console {
  /// Requests input from the console after displaying a prompt.
  ///
  ///     final name = console.ask('What is your name?'.consoleText());
  ///     console.plain('Hello $name!');
  ///
  /// The above code outputs:
  ///
  ///     What is your name?
  ///     > Seven
  ///     Hello Seven!
  ///
  /// if [newline] is `false`, the prompt will be displayed on the same line as
  /// the input:
  ///
  ///   final name = console.ask('What is your name?'.consoleText(), newline: false);
  ///   console.plain('Hello $name!');
  ///
  /// The above code outputs:
  ///
  /// ```
  /// What is your name? > Seven
  /// Hello Seven!
  /// ```
  ///
  /// If [secure] is `true`, the input will be hidden from the console.
  String ask(ConsoleText prompt, {bool secure = false, bool newline = true}) {
    final text = switch (newline) {
      true => ConsoleText('${Platform.lineTerminator}> '),
      false => ConsoleText(' > '),
    };

    output(prompt + text, newline: false);

    return input(secure: secure);
  }
}
