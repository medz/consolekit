import '../command_input.dart';
import '_internal/any_signature.dart';

class CommandFlag extends AnyFlag {
  const CommandFlag(
    super.name, {
    super.help,
    super.short,
  });

  @override
  void load(CommandInput input) {
    AnySignatureValue.storage[this] = input.moveNextFlag(name, short);
  }
}
