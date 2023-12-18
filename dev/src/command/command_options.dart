import 'command_input.dart';
import 'signatures/_internal/any_signature.dart';

class CommandOption extends AnyOption {
  const CommandOption(
    super.name, {
    super.help,
    this.defaultsTo,
    super.optional,
    super.short,
    super.possible,
    super.possibleHelp,
  });

  /// Defines the default value of the value.
  final String? defaultsTo;

  @override
  void load(CommandInput input) {
    final value = input.moveNextOption(name, short);
    if (!optional) ArgumentError.checkNotNull(value, name);

    AnySignatureValue.storage[this] = value ?? defaultsTo;
  }
}
