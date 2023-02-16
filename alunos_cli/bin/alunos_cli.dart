import 'package:alunos_cli/commands/students/students_command.dart';
import 'package:args/command_runner.dart';

void main(List<String> arguments) {
  // final argParser = ArgParser();
  // argParser.addFlag('data', abbr: 'd');
  // argParser.addOption('name', abbr: 'n');
  // argParser.addOption('template', abbr: 't');
  // final argResult = argParser.parse(arguments);

  // print('${argResult['data']}');
  // print('${argResult['name']}ad');
  // print('${argResult['template']}');

  CommandRunner('ADF CLI', 'ADF CLI')
    ..addCommand(StudentsCommand())
    ..run(arguments);
}
