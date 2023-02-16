import 'package:args/args.dart';
import 'package:args/command_runner.dart';

void main(List<String> arguments) {
  // final argParser = ArgParser();
  // argParser.addFlag('data', abbr: 'd');
  // argParser.addOption('name', abbr: 'n');
  // argParser.addOption('template', abbr: 't');
  // final argResult = argParser.parse(arguments);

  // print('${argResult['data']}');
  // print('${argResult['name']}');
  // print('${argResult['template']}');

  CommandRunner('ADF CLI', 'ADF CLI')
    ..addCommand(ExemploCommmand())
    ..run(arguments);
}

class ExemploCommmand extends Command {
  ExemploCommmand() {
    argParser.addOption('template', abbr: 't', help: 'Template de criação do projeto');
  }

  @override
  String get description => 'Exemplo de Comando';

  @override
  String get name => 'exemplo';

  @override
  void run() {
    print(argResults?['template']);
    print('Qualquer coisa');
  }
}
