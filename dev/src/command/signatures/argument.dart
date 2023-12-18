import '../command_input.dart';
import '_internal/any_signature.dart';

class Argument extends AnyArgument {
  const Argument(super.name, {super.defaultsTo, super.help, super.optional});

  @override
  void load(CommandInput input) {
    final value = input.moveNextArgument();
    if (value == null && optional) return;
    ArgumentError.checkNotNull(value, name);
    AnySignatureValue.storage[this] = value;
  }
}
