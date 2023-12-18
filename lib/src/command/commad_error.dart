class CommandError extends Error {
  final String message;

  CommandError(this.message);

  @override
  String toString() => 'CommandError: $message';
}
