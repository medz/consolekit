import '../console.dart';
import '../output/console_text.dart';

class ConsoleChooseItem<T> {
  final ConsoleText text;
  final T value;

  const ConsoleChooseItem(this.text, this.value);
}

extension ConsoleChoose<T> on Console {
  /// Requests a choice from the user after a prompt.
  ///
  /// ```dart
  /// final choice = console.choose(
  ///   'Choose a number:'.consoleText(),
  ///   items: [
  ///     ConsoleChooseItem('One'.consoleText(), 1),
  ///     ConsoleChooseItem('Two'.consoleText(), 2),
  ///     ConsoleChooseItem('Three'.consoleText(), 3),
  ///   ],
  /// );
  /// console.plain('You chose: $choice');
  /// ```
  ///
  /// The above code outputs:
  /// ```
  /// Choose a number:
  /// 1) One
  /// 2) Two
  /// 3) Three
  /// > 2
  /// You chose: 2
  /// ```
  T choose(ConsoleText prompt, {required List<ConsoleChooseItem<T>> items}) {
    output(prompt, newline: true);

    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      output(ConsoleText('${i + 1}) ') + item.text, newline: true);
    }

    output(ConsoleText('> '));

    while (true) {
      final input = this.input(secure: false);
      final index = int.tryParse(input);
      if (index != null && index > 0 && index <= items.length) {
        return items[index - 1].value;
      }

      output(
        ConsoleText('Please enter a number between 1 and ${items.length} > '),
        newline: false,
      );
    }
  }
}
