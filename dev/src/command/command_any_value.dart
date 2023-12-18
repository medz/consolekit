import 'command_input.dart';

abstract class CommandAnyValue<T> {
  /// Returns the value of the command value.
  T? value;

  /// Defines the name of the value.
  final String name;

  /// Defines the help text for the value.
  final String? description;

  /// Defines whether the value is optional.
  final bool optional;

  CommandAnyValue(
    this.name, {
    this.description,
    this.optional = false,
    T? defaultsTo,
  }) : value = defaultsTo;

  /// Setups the command value.
  void setup(CommandInput input);
}
