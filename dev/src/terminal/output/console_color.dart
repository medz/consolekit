class ConsoleColor {
  final int hex; // 0xrrggbb

  const ConsoleColor(int hex) : hex = hex & 0xFFFFFF;

  @override
  String toString() => '0x${hex.toRadixString(16).padLeft(6, '0')}';

  //---------------------- Normal Colors ----------------------//
  /// ![](https://via.placeholder.com/15/000000/000000?text=+) `#000000`
  static const ConsoleColor black = ConsoleColor(0x000000);

  /// ![](https://via.placeholder.com/15/800000/000000?text=+) `#800000`
  static const ConsoleColor red = ConsoleColor(0x800000);

  /// ![](https://via.placeholder.com/15/008000/000000?text=+) `#008000`
  static const ConsoleColor green = ConsoleColor(0x008000);

  /// ![](https://via.placeholder.com/15/808000/000000?text=+) `#808000`
  static const ConsoleColor yellow = ConsoleColor(0x808000);

  /// ![](https://via.placeholder.com/15/000080/000000?text=+) `#000080`
  static const ConsoleColor blue = ConsoleColor(0x000080);

  /// ![](https://via.placeholder.com/15/800080/000000?text=+) `#800080`
  static const ConsoleColor magenta = ConsoleColor(0x800080);

  /// ![](https://via.placeholder.com/15/008080/000000?text=+) `#008080`
  static const ConsoleColor cyan = ConsoleColor(0x008080);

  /// ![](https://via.placeholder.com/15/c0c0c0/000000?text=+) `#c0c0c0`
  static const ConsoleColor gray = ConsoleColor(0xc0c0c0);

  /// ![](https://via.placeholder.com/15/ffffff/000000?text=+) `#ffffff`
  static const ConsoleColor white = ConsoleColor(0xffffff);

  //---------------------- Bright Colors ----------------------//
  /// ![](https://via.placeholder.com/15/000000/000000?text=+) `#000000`
  static const ConsoleColor blackBright = ConsoleColor(0x000000);

  /// ![](https://via.placeholder.com/15/ff0000/000000?text=+) `#ff0000`
  static const ConsoleColor redBright = ConsoleColor(0xff0000);

  /// ![](https://via.placeholder.com/15/00ff00/000000?text=+) `#00ff00`
  static const ConsoleColor greenBright = ConsoleColor(0x00ff00);

  /// ![](https://via.placeholder.com/15/ffff00/000000?text=+) `#ffff00`
  static const ConsoleColor yellowBright = ConsoleColor(0xffff00);

  /// ![](https://via.placeholder.com/15/0000ff/000000?text=+) `#0000ff`
  static const ConsoleColor blueBright = ConsoleColor(0x0000ff);

  /// ![](https://via.placeholder.com/15/ff00ff/000000?text=+) `#ff00ff`
  static const ConsoleColor magentaBright = ConsoleColor(0xff00ff);

  /// ![](https://via.placeholder.com/15/00ffff/000000?text=+) `#00ffff`
  static const ConsoleColor cyanBright = ConsoleColor(0x00ffff);

  /// ![](https://via.placeholder.com/15/ffffff/000000?text=+) `#ffffff`
  static const ConsoleColor whiteBright = ConsoleColor(0xffffff);
}

extension ConsoleColorExtension on ConsoleColor {
  int get r => (hex >> 16) & 0xFF;
  int get g => (hex >> 8) & 0xFF;
  int get b => hex & 0xFF;
}
