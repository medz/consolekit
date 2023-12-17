import 'output/console_color.dart';
import 'output/console_style.dart';
import 'output/console_text.dart';

/// Terminal ANSI commands
class ANSICommand {
  final String ansi;

  const ANSICommand._(this.ansi);

  static const eraseScreen = ANSICommand._('\x1B[2J');
  static const eraseLine = ANSICommand._('\x1B[2K');
  static const cursorUp = ANSICommand._('\x1B[1A');

  factory ANSICommand.sgr(Iterable<ANSISGRCommand> commands) =>
      ANSICommand._('\x1B[${commands.join(';')}m');

  @override
  String toString() => ansi;
}

/// Terminal ANSI SGR commands
class ANSISGRCommand {
  final String ansi;

  @override
  String toString() => ansi;

  const ANSISGRCommand._(this.ansi);

  /// Set Normal (all attributes off).
  static const reset = ANSISGRCommand._('0');

  /// Set Bold.
  static const bold = ANSISGRCommand._('1');

  /// Underline
  static const underline = ANSISGRCommand._('4');

  /// Blink (not very fast)
  static const blink = ANSISGRCommand._('5');

  /// Traditional foreground color
  factory ANSISGRCommand.foregroundColor(int color) {
    return ANSISGRCommand._('3$color');
  }

  /// Traditional bright foreground color.
  factory ANSISGRCommand.foregroundColorBright(int color) {
    return ANSISGRCommand._('9$color');
  }

  /// Palette foreground color
  factory ANSISGRCommand.foregroundColorPalette(int color) {
    return ANSISGRCommand._('38;5;$color');
  }

  /// RGB "true-color" foreground color.
  factory ANSISGRCommand.foregroundColorRGB(int r, int g, int b) {
    return ANSISGRCommand._('38;2;$r;$g;$b');
  }

  /// Keep current foreground color (effective no-op).
  static const foregroundColorKeep = ANSISGRCommand._('39');

  /// Traditional background color.
  factory ANSISGRCommand.backgroundColor(int color) {
    return ANSISGRCommand._('4$color');
  }

  /// Traditional bright background color.
  factory ANSISGRCommand.backgroundColorBright(int color) {
    return ANSISGRCommand._('10$color');
  }

  /// Palette background color.
  factory ANSISGRCommand.backgroundColorPalette(int color) {
    return ANSISGRCommand._('48;5;$color');
  }

  /// RGB "true-color" background color.
  factory ANSISGRCommand.backgroundColorRGB(int r, int g, int b) {
    return ANSISGRCommand._('48;2;$r;$g;$b');
  }

  /// Keep current background color (effective no-op).
  static const backgroundColorKeep = ANSISGRCommand._('49');
}

class ANSISGRColorSpec {
  final ANSISGRCommand foregroundAnsiCommand;
  final ANSISGRCommand backgroundAnsiCommand;

  const ANSISGRColorSpec._({
    required this.foregroundAnsiCommand,
    required this.backgroundAnsiCommand,
  });

  static const default_ = ANSISGRColorSpec._(
    foregroundAnsiCommand: ANSISGRCommand.foregroundColorKeep,
    backgroundAnsiCommand: ANSISGRCommand.backgroundColorKeep,
  );

  factory ANSISGRColorSpec.rgb(int r, int g, int b) => ANSISGRColorSpec._(
        foregroundAnsiCommand: ANSISGRCommand.foregroundColorRGB(r, g, b),
        backgroundAnsiCommand: ANSISGRCommand.backgroundColorRGB(r, g, b),
      );

  factory ANSISGRColorSpec.palette(int color) => ANSISGRColorSpec._(
        foregroundAnsiCommand: ANSISGRCommand.foregroundColorPalette(color),
        backgroundAnsiCommand: ANSISGRCommand.backgroundColorPalette(color),
      );

  factory ANSISGRColorSpec.traditional(int color) => ANSISGRColorSpec._(
        foregroundAnsiCommand: ANSISGRCommand.foregroundColor(color),
        backgroundAnsiCommand: ANSISGRCommand.backgroundColor(color),
      );

  factory ANSISGRColorSpec.bright(int color) => ANSISGRColorSpec._(
        foregroundAnsiCommand: ANSISGRCommand.foregroundColorBright(color),
        backgroundAnsiCommand: ANSISGRCommand.backgroundColorBright(color),
      );
}

extension ConsoleTextTerminalStylize on ConsoleText {
  /// Wraps a string in the ANSI codes indicated by the [ConsoleText] object.
  String terminalStylize() =>
      map((e) => e.text.terminalStylize(e.style)).join();
}

extension StringTerminalStylize on String {
  /// Wraps a string in the ANSI codes indicated by the [String] object.
  String terminalStylize(ConsoleStyle style) {
    if (!style.bold && style.background == null && style.color == null) {
      return this; // No styling
    }

    return style.ansiCommand.ansi +
        this +
        ANSICommand.sgr([ANSISGRCommand.reset]).ansi;
  }
}

extension on ConsoleStyle {
  /// The ANSI command for this console style.
  ANSICommand get ansiCommand {
    final commands = <ANSISGRCommand>[
      ANSISGRCommand.reset,
      if (bold) ANSISGRCommand.bold,
      if (color != null) color!.ansiSpec.foregroundAnsiCommand,
      if (background != null) background!.ansiSpec.backgroundAnsiCommand,
    ];

    return ANSICommand.sgr(commands);
  }
}

extension on ConsoleColor {
  /// The ANSI command for this console color.
  ANSISGRColorSpec get ansiSpec => ANSISGRColorSpec.rgb(r, g, b);
}
