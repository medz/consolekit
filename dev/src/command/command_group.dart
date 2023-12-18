import 'dart:async';

import '../output/console_output.dart';
import '../output/console_style.dart';
import '_internal/output_help_list_child.dart';
import 'command.dart';
import 'command_context.dart';
import 'signatures/command_signature.dart';

class CommandGroup implements Command {
  final Map<String, Command> commands;
  final Command? defaultCommand;

  CommandGroup(
      {this.commands = const {}, this.defaultCommand, this.description});

  @override
  final String? description;

  @override
  CommandSignature get signature => throw UnimplementedError();

  @override
  FutureOr<void> run(CommandContext context) {
    final (command) = commmand(context);
    if (command != null) {
      return command.run(context);
    } else if (defaultCommand != null) {
      return defaultCommand?.run(context);
    }

    outputHelp(context);
  }

  void outputHelp(CommandContext context) {
    context.console.info('Usage: ', newline: false);
    context.console.plain(context.input.executable, newline: false);
    context.console.warning(' <command>');

    if (description?.isNotEmpty == true) {
      context.console.newline();
      context.console.plain(description!);
    }

    final padding =
        commands.keys.map((it) => it.length).reduce((a, b) => a > b ? a : b);
    if (commands.isNotEmpty) {
      context.console.newline();
      context.console.success('Commands:');
      for (final command in commands.entries) {
        context.console.outputHelpListChind(
          command.key,
          help: command.value.description,
          style: ConsoleStyle.warning,
          padding: padding,
        );
      }
    }
  }
}

extension on CommandGroup {
  Command? commmand(CommandContext context) {
    final name = context.input.moveNext()?.trim();
    if (name == null) return null;

    final command = commands[name];
    if (command == null) {
      throw ArgumentError.value(
        name,
        'name',
        'No command found with the name "$name".',
      );
    }

    context.input.appendExecutablePath(name);
    return command;
  }
}
