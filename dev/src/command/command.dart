import 'dart:async';

import 'command_context.dart';
import 'signatures/command_signature.dart';

abstract class Command<Signature extends CommandSignature> {
  const Command();

  /// Defines the signature of the command.
  Signature get signature;

  /// Text that will be displayed when `--help` is passed.
  String? get description;

  /// Runs the command.
  FutureOr<void> run(CommandContext context);
}
