import '../command_input.dart';
import '_internal/any_signature.dart';

/// The structure of the inputs that a command can take.
///
/// ```dart
/// class Signature extends CommandSignature {
///   /// Initialize the signature.
///   Signature() {
///     arguments.add(Argument('name', help: 'The name of the person.'));
///     flags.add(Flag('greeting', abbr: 'g', help: 'The greeting to use.'));
///   }
///
///   /// Returns the greeting to use.
///   bool get greeting => flags.valueOf('greeting');
///
///   /// Returns the name of the person.
///   String get name => arguments.valueOf('name');
/// }
/// ```
abstract class CommandSignature {
  final _arguments = <AnyArgument>[];
  final _flags = <AnyFlag>[];
  final _options = <AnyOption>[];

  CommandSignature();

  void load(CommandInput input) {
    _arguments.load(input);
    _flags.load(input);
    _options.load(input);
  }
}

extension on Iterable<AnySignatureValue> {
  void load(CommandInput input) => forEach((value) => value.load(input));
}

extension ValueOf on Iterable<AnySignatureValue> {
  /// Returns the value of the argument/flag/option with the given [name].
  ///
  /// - Calling the method on a flag, the value will be a [bool].
  /// - Calling the method on an argument/option, the value will be a [String?].
  ///
  /// The [convert] function can be used to convert the value to a different
  /// type.
  Object? valueOf(String name) {
    final instance = firstWhereOrNull((element) => element.name == name);
    final value = AnySignatureValue.storage[instance];

    return switch (instance) {
      AnyFlag flag => value ?? flag.defaultsTo,
      AnyOption option => value ?? option.defaultsTo,
      _ => value,
    };
  }
}

extension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    try {
      return firstWhere(test);
    } on StateError {
      return null;
    }
  }
}
