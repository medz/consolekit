class CommandInput extends Iterable<String> {
  /// Internal arguments that are not removed when moving through the command
  /// input.
  late final List<String> _internalArguments;

  CommandInput(String executable, Iterable<String> arguments) {
    _internalArguments = List.from(arguments);
    executablePath.add(executable);
  }

  /// Internal executable path that is not removed when moving through the
  /// command input.
  final executablePath = <String>[];

  /// Returns the executable path.
  String get executable => executablePath.join(' ');

  /// Adds the given argument to the command input.
  void add(String argument) => _internalArguments.add(argument);

  /// Adds the given arguments to the command input.
  void addAll(Iterable<String> arguments) =>
      _internalArguments.addAll(arguments);

  @override
  Iterator<String> get iterator => _internalArguments.iterator;

  /// Returns the next segment of the command input.
  String? moveNext() {
    if (_internalArguments.isNotEmpty) {
      return _internalArguments.removeAt(0);
    }

    return null;
  }

  /// Appends the given argument to the command input.
  void movePrevious(String argument) {
    _internalArguments.insert(0, argument);
  }

  /// Returns the next argument that is not a flag.
  ///
  /// If matched, the argument is removed from the command input.
  ///
  /// ```sh
  /// dart run example.dart build --release
  /// ```
  ///
  /// In the above example, `build` is the next argument.
  String? moveNextArgument() {
    return switch (firstIndexWhere((element) => !element.startsWith('-'))) {
      int index => _internalArguments.removeAtOrNull(index),
      _ => null,
    };
  }

  /// Returns the next flag that matches the given name.
  ///
  /// If matched, the flag is removed from the command input.
  ///
  /// ```sh
  /// dart run example.dart build --release
  /// ```
  ///
  /// In the above example, `--release` is the next flag.
  bool moveNextFlag(String name, [String? short]) {
    final index = findNextFlagIndex(name, short);
    if (index == null) return false;

    _internalArguments.removeAtOrNull(index);
    return true;
  }

  /// Returns the next option that matches the given name.
  ///
  /// If matched, the option is removed from the command input.
  ///
  /// ```sh
  /// dart run example.dart build --output=build
  /// dart run example.dart build --output build
  /// dart run example.dart build -o build // short
  /// ```
  ///
  /// In the above example, `--output=build` is the next option, return
  /// `build` as the value.
  String? moveNextOption(String name, [String? short]) {
    final (flagIndex, valueIndex) = findNextOptionIndex(name, short);
    if (flagIndex == null) return null;
    if (valueIndex == null) return null;

    final offset = switch (_internalArguments[valueIndex]) {
      String(startsWith: final startsWith) when startsWith('--$name=') =>
        name.length + 3,
      String(startsWith: final startsWith)
          when short != null && startsWith('-$short=') =>
        short.length + 2,
      _ => 0,
    };

    final value = _internalArguments[valueIndex].substring(offset);
    if (value.isEmpty || value.startsWith('-')) return null;

    _internalArguments.removeRange(flagIndex, valueIndex);

    return value;
  }
}

extension on CommandInput {
  int? findNextFlagIndex(String name, [String? short]) {
    final index = firstIndexWhere((element) => element == '--$name');
    if (index != null) {
      return index;
    } else if (short != null) {
      return firstIndexWhere((element) => element == '-$short');
    }

    return null;
  }

  (int? flagIndex, int? valueIndex) findNextOptionIndex(String name,
      [String? short]) {
    final flagIndex = findNextFlagIndex(name, short);
    if (flagIndex != null) {
      if (flagIndex + 1 < length) {
        return (flagIndex, flagIndex + 1);
      }

      return (flagIndex, null);
    }

    final index = firstIndexWhere((element) => element.startsWith('--$name='));
    if (index != null) {
      return (index, index);
    } else if (short != null) {
      final index =
          firstIndexWhere((element) => element.startsWith('-$short='));
      return (index, index);
    }

    return (null, null);
  }
}

extension<T> on Iterable<T> {
  int? firstIndexWhere(bool Function(T element) test) {
    for (var i = 0; i < length; i++) {
      if (test(elementAt(i))) {
        return i;
      }
    }
    return null;
  }
}

extension<T> on List<T> {
  T? removeAtOrNull(int index) {
    if (index < length) {
      return removeAt(index);
    }

    return null;
  }
}
