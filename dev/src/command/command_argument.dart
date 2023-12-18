import 'commad_error.dart';
import 'command_any_value.dart';
import 'command_input.dart';

class CommandArgument extends CommandAnyValue<String> {
  CommandArgument(
    super.name, {
    super.description,
    super.optional,
    super.defaultsTo,
  });

  @override
  void setup(CommandInput input) {
    final value = input.moveNextArgument();
    if (optional && value == null) return;

    if (value == null) {
      throw CommandError('Missing required argument: $name');
    }

    this.value = value;
  }
}
