import '../console.dart';
import 'command_input.dart';

class CommandContext {
  /// Current console instance.
  final Console console;
  final CommandInput input;
  final Map userinfo = {};

  CommandContext(this.console, this.input);
}
