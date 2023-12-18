import 'dart:async';
import 'dart:math';

import '../../terminal.dart';
import '../output/console_output.dart';
import '../output/console_style.dart';
import '_internal/output_help_list_child.dart';
import 'command.dart';
import 'command_context.dart';
import 'command_input.dart';

class CommandGroup extends Command {
  late final Map<String, Command> commands;
  final Command? defaultCommand;

  CommandGroup(
      {Map<String, Command>? commands, this.defaultCommand, this.description}) {
    this.commands = commands ?? {};
  }

  @override
  final String? description;

  @override
  FutureOr<void> run(CommandContext context) {
    // final (command) = commmand(context);
    // if (command != null) {
    //   return command.run(context);
    // } else if (defaultCommand != null) {
    //   return defaultCommand?.run(context);
    // }

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

    final padding = switch (commands) {
      Map(isEmpty: true) => 2,
      Map(keys: final keys) => keys.map((it) => it.length).reduce(max),
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

void main(List<String> args) {
  final group = CommandGroup();
  final context = CommandContext(
    Terminal(),
    CommandInput(args),
  );

  group.commands['demo'] = DemoCommand();

  group.run(context);
}

class DemoCommand extends Command {
  @override
  String get description => 'Demo';

  @override
  FutureOr<void> run(CommandContext context) {
    // TODO: implement run
    throw UnimplementedError();
  }
}
