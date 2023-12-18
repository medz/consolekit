import '../command_input.dart';
import '_internal/any_signature.dart';

class CommandArgument extends AnyArgument {
  const CommandArgument(
    super.name, {
    super.defaultsTo,
    super.help,
    super.optional,
  });

  @override
  void load(CommandInput input) {
    final value = input.moveNextArgument();
    if (!optional) ArgumentError.checkNotNull(value, name);

    AnySignatureValue.storage[this] = value ?? defaultsTo;
  }
}
