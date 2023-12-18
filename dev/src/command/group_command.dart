import 'dart:async';
import 'dart:math';

import '../output/console_output.dart';
import '../output/console_style.dart';
import '../output/console_text.dart';
import '_internal/output_help_list_child.dart';
import 'commad_error.dart';
import 'command.dart';
import 'command_any_value.dart';
import 'command_context.dart';
import 'command_input.dart';

extension<T extends CommandAnyValue> on Iterable<T> {
  void setup(CommandInput input) => forEach((element) => element.setup(input));
}

extension on Command {
  /// Setups the command arguments, options, and flags.
  void setup(CommandInput input) {
    arguments.setup(input);
    options.setup(input);
    flags.setup(input);
  }
}

abstract class GroupCommand extends Command {
  late final Map<String, Command> commands;
  final Command? defaultCommand;

  GroupCommand(
      {Map<String, Command>? commands, this.defaultCommand, this.description}) {
    this.commands = commands ?? {};
  }

  @override
  final String? description;

  @override
  FutureOr<void> run(CommandContext context) {
    try {
      final command = commmand(context) ?? defaultCommand;
      if (command != null) {
        try {
          command.setup(context.input);
          return command.run(context);
        } catch (e) {
          command.printHelp(context);
          rethrow;
        }
      }

      printHelp(context);
      throw CommandError('No command provided.');
    } on CommandError catch (error) {
      final message =
          'Error: ${error.message}'.consoleText(style: ConsoleStyle.error);
      context.console.report(message);
    }
  }

  @override
  void printHelp(CommandContext context) {
    context.console.info('Usage: ', newline: false);
    context.console.plain(context.input.executable, newline: false);
    context.console.warning(' <command>');

    if (description?.isNotEmpty == true) {
      context.console.newline();
      context.console.plain(description!);
    }

    final padding = switch (commands) {
      Map(isEmpty: true) => 2,
      Map(keys: final keys) => keys.map((it) => it.length).reduce(max) + 2,
    };

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

extension on GroupCommand {
  Command? commmand(CommandContext context) {
    final name = context.input.moveNext()?.trim();
    if (name == null) return null;

    final command = commands[name];
    if (command == null) {
      printHelp(context);
      throw CommandError('Command not found: $name');
    }

    context.input.appendExecutablePath(name);
    return command;
  }
}
