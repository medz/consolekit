import 'dart:io';

import '../console.dart';
import '../output/console_text.dart';

extension on Console {
  /// Parse a [bool] from string.
  bool? parseBoolean(String value) => switch (value) {
        'y' || 'yes' => true,
        'n' || 'no' => false,
        _ => null,
      };
}

extension ConsoleConfirm on Console {
  /// Requests yes / no confirmation from the user after a prompt.
  ///
  /// ```dart
  /// final confirmed = console.confirm('Are you sure?'.consoleText());
  /// if (confirmed) {
  ///   console.plain('You are sure!');
  /// } else {
  ///   console.plain('You are not sure!');
  /// }
  /// ```
  ///
  /// The above code outputs:
  /// ```
  /// Are you sure? (y/n)
  /// > y
  /// You are sure!
  /// ```
  bool confirm(ConsoleText prompt, {bool newline = false}) {
    final text = switch (newline) {
      true => ConsoleText(' (y/n) ${Platform.lineTerminator}> '),
      false => ConsoleText(' (y/n) > '),
    };

    output(prompt + text, newline: false);

    while (true) {
      final result = parseBoolean(input(secure: false));
      if (result != null) return result;

      output(prompt, newline: true);
      output(
        ConsoleText('Please enter "y"/"yes" or "n"/"no" > '),
        newline: false,
      );
    }
  }
}
