import '../console.dart';
import '../output/console_style.dart';
import '../output/console_text.dart';
import 'commad_error.dart';
import 'command.dart';
import 'command_context.dart';
import 'command_input.dart';

extension ConsoleRun on Console {
  /// Runs a [Command] with the given [CommandContext].
  Future<void> runWithContext(Command command, CommandContext context) async {
    try {
      await command.run(context);
    } on CommandError catch (error) {
      final message =
          'Error: ${error.message}'.consoleText(style: ConsoleStyle.error);
      report(message);
    }
  }

  /// Runs a [Command] with the given [CommandInput].
  Future<void> runWithInput(Command command, CommandInput input) {
    return runWithContext(command, CommandContext(this, input));
  }

  /// Runs a [Command] with the given iterable of [arguments].
  Future<void> run({
    required String executable,
    required Command command,
    Iterable<String> arguments = const [],
  }) {
    return runWithInput(command, CommandInput(executable, arguments));
  }
}
