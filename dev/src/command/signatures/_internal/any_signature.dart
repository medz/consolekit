import '../../command_input.dart';

abstract class AnySignatureValue {
  static final Map<AnySignatureValue, dynamic /* String | bool */ > storage =
      {};

  const AnySignatureValue(
    this.name, {
    this.help = '',
    this.optional = false,
    this.defaultsTo,
  });

  /// Defines the name of the value.
  final String name;

  /// Defines the help text for the value.
  final String help;

  // Defines whether the value is optional.
  final bool optional;

  /// Defines the default value of the value.
  final String? defaultsTo;

  /// Loads the value from the given [input].
  void load(CommandInput input);
}

abstract class AnyArgument extends AnySignatureValue {
  const AnyArgument(
    super.name, {
    super.help,
    super.defaultsTo,
    super.optional,
  });
}

abstract class AnyOption extends AnySignatureValue {
  const AnyOption(
    super.name, {
    super.help,
    super.defaultsTo,
    super.optional,
    this.short,
    this.possible,
    this.possibleHelp,
  });

  /// Defines the short name of the flag.
  final String? short;

  /// Defines the possible values of the option.
  final Iterable<String>? possible;

  /// Defines the possible values help text of the option.
  final Map<String, String>? possibleHelp;
}

abstract class AnyFlag extends AnySignatureValue {
  const AnyFlag(
    super.name, {
    super.help,
    super.defaultsTo,
    this.short,
  });

  /// Defines the short name of the flag.
  final String? short;
}
