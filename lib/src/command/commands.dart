import 'command.dart';
import 'group_command.dart';

class Commands {
  final Map<String, Command> commands = {};
  Command? defaultCommand;

  Commands({Map<String, Command>? commands, this.defaultCommand}) {
    if (commands != null) {
      this.commands.addAll(commands);
    }
  }

  /// Appends a command to the list of commands.
  ///
  /// ```dart
  /// final commands = Commands();
  /// commands.use('foo', fooCommand);
  /// commands.use('bar', barCommand, isDefault: true);
  /// ```
  void use(String name, Command command, {bool isDefault = false}) {
    commands[name] = command;
    if (isDefault) {
      defaultCommand = command;
    }
  }

  /// Creates a new [GroupCommand] with the [Commands] as the commands.
  ///
  /// ```dart
  /// final commands = Commands();
  ///
  /// commands.use('foo', fooCommand);
  /// commands.use('bar', barCommand);
  ///
  /// final group = commands.group(description: 'My group');
  ///
  /// console.run(group);
  /// ```
  GroupCommand group({String? description}) => _InternalGroupCommand(
        commands: commands,
        defaultCommand: defaultCommand,
        description: description,
      );
}

class _InternalGroupCommand extends GroupCommand {
  _InternalGroupCommand({
    super.commands,
    super.defaultCommand,
    super.description,
  });
}
