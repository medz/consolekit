import 'dart:async';

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
  Iterable<CommandFlag> get flags => const [
        CommandFlag('help',
            short: 'h', help: 'Displays this help information.'),
      ];

  /// Runs the command.
  FutureOr<void> run(CommandContext context);
}
