## Console Kit Example

This is an example of how to use the console kit.

### Terminal

```dart
final console = Terminal();

console.output('Hello World!'.consoleText(color: ConsoleColor.yellowBright));
console.success('Hello World!');
console.info('Hello World!');
console.warning('Hello World!');
console.error('Hello World!');
console.plain('Hello World!');
```

[Read the full example](https://github.com/medz/consolekit/blob/main/example/terminal.dart)

## Commands

```dart
class HelloCommand extends Command {
    @override
    void run(context) {
        context.console.plain('Hello World!');
    }
}

final console = Terminal();

console.run(
    executable: "hello",
    command: HelloCommand(),
);
```

[Read the full example](https://github.com/medz/consolekit/blob/main/example/command.dart)
