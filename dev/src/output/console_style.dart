import 'console_color.dart';

/// Representation of a style for outputting to a Console in different colors
/// with differing attributes.
///
/// A few suggested default styles are provided.
class ConsoleStyle {
  /// Optional text color, if null, text is plain.
  final ConsoleColor? color;

  /// Optional background color, if null, background is plain.
  final ConsoleColor? background;

  /// If `true`, text is bold.
  final bool bold;

  const ConsoleStyle({this.color, this.background, this.bold = false});

  /// Plain text with no color or background.
  static const plain = ConsoleStyle();

  /// Green text with no background.
  static const success = ConsoleStyle(color: ConsoleColor.green);

  /// Light blue text with no background.
  static const info = ConsoleStyle(color: ConsoleColor.cyan);

  /// Yellow text with no background.
  static const warning = ConsoleStyle(color: ConsoleColor.yellow);

  /// Red text with no background.
  static const error = ConsoleStyle(color: ConsoleColor.red);
}
