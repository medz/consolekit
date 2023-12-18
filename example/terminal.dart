import 'package:consolekit/consolekit.dart';
import 'package:consolekit/terminal.dart';

void main(List<String> args) {
  final console = Terminal();

  console.output('Hello World!'.consoleText(color: ConsoleColor.yellowBright));
  console.success('Hello World!');
  console.info('Hello World!');
  console.warning('Hello World!');
  console.error('Hello World!');
  console.plain('Hello World!');
}
