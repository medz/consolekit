import 'dart:async';
import 'dart:math';

import '../console.dart';
import '../output/console_output.dart';
import '../output/console_style.dart';
import '../output/console_text.dart';
import '_internal/output_help_list_child.dart';
import 'command_any_value.dart';
import 'command_context.dart';
import 'command_argument.dart';
import 'command_flag.dart';
import 'command_options.dart';

abstract class Command {
  const Command();

  /// Text that will be displayed when `--help` is passed.
  String? get description => null;

  /// Defines the command arguments
  Iterable<CommandArgument> get arguments => const [];

  /// Defines the command options
  Iterable<CommandOption> get options => const [];

  /// Defines the command flags.
  Iterable<CommandFlag> get flags => [
        CommandFlag('help',
            short: 'h', description: 'Displays this help information.'),
      ];

  /// Runs the command.
  FutureOr<void> run(CommandContext context);

  /// Prints the help information for this command.
  void printHelp(CommandContext context) {
    context.console.info('Usage: ', newline: false);
    context.console.plain(context.input.executable, newline: false);

    arguments.printShortHelp(context.console);
    options.printShortHelp(context.console);
    flags.printShortHelp(context.console);

    context.console.newline();
    if (description?.isNotEmpty == true) {
      context.console.newline();
      context.console.plain(description!);
    }

    final lengths = [
      ...arguments.map((e) => e.name.length),
      ...options.map((e) => e.name.length),
      ...flags.map((e) => e.name.length),
    ];
    final padding = switch (lengths) {
      Iterable(isEmpty: true) => 2,
      Iterable<int>(reduce: final reduce) => reduce(max) + 2,
    };

    arguments.printHelp(
      console: context.console,
      padding: padding,
      name: 'Arguments',
      style: ConsoleStyle.info,
    );
    options.printHelp(
      console: context.console,
      padding: padding,
      name: 'Options',
      style: ConsoleStyle.success,
    );
    flags.printHelp(
      console: context.console,
      padding: padding,
      name: 'Flags',
      style: ConsoleStyle.success,
    );
  }
}

extension<T extends CommandAnyValue> on Iterable<T> {
  /// Prints the help information for the command arguments/options/flags.
  void printHelp({
    required Console console,
    required int padding,
    required String name,
    required ConsoleStyle style,
  }) {
    if (isEmpty) return;

    console.newline();
    console.info(name, newline: false);
    console.plain(':');
    for (final element in this) {
      console.outputHelpListChind(
        element.name,
        style: style,
        padding: padding,
        help: element.description,
      );
    }
  }
}

extension on Iterable<CommandArgument> {
  /// Prints the short help information for the command arguments.
  void printShortHelp(Console console) {
    final fragments = <ConsoleTextFragment>[];
    for (final argument in this) {
      fragments.add(ConsoleTextFragment(' <'));
      fragments.add(ConsoleTextFragment(argument.name, ConsoleStyle.warning));

      if (argument.optional) {
        fragments.add(ConsoleTextFragment('?'));
      }
      fragments.add(ConsoleTextFragment('>'));
    }

    console.output(ConsoleText.fragment(fragments), newline: false);
  }
}

extension on Iterable<CommandOption> {
  /// Prints the short help information for the command options.
  void printShortHelp(Console console) {
    final fragments = <ConsoleTextFragment>[];
    for (final option in this) {
      fragments.add(ConsoleTextFragment(' ['));
      fragments
          .add(ConsoleTextFragment('--${option.name}', ConsoleStyle.success));
      if (option.short != null) {
        fragments.add(
            ConsoleTextFragment(',-${option.short}', ConsoleStyle.success));
      }
      fragments.add(ConsoleTextFragment('='));
      fragments.add(ConsoleTextFragment('<value>', ConsoleStyle.warning));

      fragments.add(ConsoleTextFragment(']'));
    }

    console.output(ConsoleText.fragment(fragments), newline: false);
  }
}

extension on Iterable<CommandFlag> {
  /// Prints the short help information for the command options.
  void printShortHelp(Console console) {
    final fragments = <ConsoleTextFragment>[];
    for (final option in this) {
      fragments.add(ConsoleTextFragment(' ['));
      fragments
          .add(ConsoleTextFragment('--${option.name}', ConsoleStyle.success));
      if (option.short != null) {
        fragments.add(
            ConsoleTextFragment(',-${option.short}', ConsoleStyle.success));
      }

      fragments.add(ConsoleTextFragment(']'));
    }

    console.output(ConsoleText.fragment(fragments), newline: false);
  }
}
