import '../command_input.dart';

/// The structure of the inputs that a command can take.
///
/// ```dart
/// class MySignature implements CommandSignature {
///   const MySignature();
///
///   final greeting =
///       CommandFlag('greeting', short: 'g', help: 'The greeting to use.');
///
///   final name = CommandArgument('name', help: 'The name of the person.');
///
///   void load(CommandInput input) {
///     greeting.load(input);
///     name.load(input);
///   }
/// }
/// ```
abstract interface class CommandSignature {
  const CommandSignature();

  /// Loads the values from the given [input].
  void load(CommandInput input);
}
