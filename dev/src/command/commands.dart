import 'command.dart';

class Commands {
  final Map<String, Command> commands;
  Command? defaultCommand;

  Commands({this.commands = const {}, this.defaultCommand});

  /// Appends a command to the list of commands.
  void use(String name, Command command, {bool isDefault = false}) {
    commands[name] = command;
    if (isDefault) {
      defaultCommand = command;
    }
  }
}
