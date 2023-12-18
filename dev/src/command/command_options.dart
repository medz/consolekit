import 'commad_error.dart';
import 'command_any_value.dart';
import 'command_input.dart';

class CommandOption extends CommandAnyValue<String> {
  CommandOption(
    super.name, {
    super.description,
    super.optional,
    super.defaultsTo,
    this.short,
    this.possible,
    this.possibleDescriptions,
  });

  /// Defines the short name of the option.
  final String? short;

  /// Defines the option's possible values.
  final Iterable<String>? possible;

  /// Defines the help text for the possible values.
  final Map<String, String>? possibleDescriptions;

  @override
  void setup(CommandInput input) {
    final value = input.moveNextOption(name, short);
    if (value == null) {
      if (optional) return;
      if (possible == null) {
        throw CommandError('Missing required option: $name');
      }

      throw CommandError('Missing required option: $name. Possible values: '
          '${possible!.map((e) => '"$e"').join(', ')}');
    } else if (possible != null) {
      if (!possible!.contains(value)) {
        throw CommandError('Invalid option: $name. Possible values: '
            '${possible!.map((e) => '"$e"').join(', ')}');
      }
    }

    this.value = value;
  }
}
