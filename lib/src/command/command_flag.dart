import 'command_any_value.dart';
import 'command_input.dart';

class CommandFlag extends CommandAnyValue<bool> {
  @override
  bool get value => super.value!;

  @override
  set value(covariant bool value) => super.value = value;

  CommandFlag(
    super.name, {
    super.description,
    this.short,
  }) : super(defaultsTo: false, optional: false);

  /// Defines the short name of the flag.
  final String? short;

  @override
  void setup(CommandInput input) {
    value = input.moveNextFlag(name, short);
  }
}
