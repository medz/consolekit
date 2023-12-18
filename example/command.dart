import 'dart:async';

import 'package:consolekit/consolekit.dart';
import 'package:consolekit/terminal.dart';

class FooCommand extends Command {
  @override
  FutureOr<void> run(CommandContext context) {
    context.console.info('Hello Foo!');
  }
}

class BarCommand extends Command {
  @override
  FutureOr<void> run(CommandContext context) {
    context.console.info('Hello Bar!');
  }
}

class SayHelloCommand extends Command {
  @override
  String get description => 'Says hello to the given name.';

  @override
  Iterable<CommandArgument> get arguments => [name];

  @override
  Iterable<CommandFlag> get flags => [loud];

  final name =
      CommandArgument('name', description: 'The name to say hello to.');
  final loud = CommandFlag('loud',
      short: 'l', description: 'Makes the greeting extra loud.');

  @override
  FutureOr<void> run(CommandContext context) {
    final message = 'Hello ${name.value}!';
    final style = loud.value ? ConsoleStyle.success : ConsoleStyle.info;

    context.console.output(
      (loud.value ? message.toUpperCase() : message).consoleText(style: style),
    );
  }
}

void main(List<String> args) async {
  final commands = Commands();
  commands.use('foo', FooCommand());
  commands.use('bar', BarCommand());
  commands.use('say-hello', SayHelloCommand(), isDefault: true);

  final group = commands.group(description: 'A group of commands.');
  final console = Terminal();

  await console.run(
    executable: 'dart run example/command.dart',
    command: group,
    arguments: args,
  );
}
