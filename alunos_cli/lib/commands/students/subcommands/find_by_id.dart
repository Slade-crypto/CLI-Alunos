// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:args/command_runner.dart';

import '../../../repositories/student_dio_repository.dart';

class FindByIdCommand extends Command {
  final StudentDioRepository repository;

  @override
  String get description => 'Find Student by id';

  @override
  String get name => 'byId';

  FindByIdCommand(this.repository) {
    argParser.addOption('id', help: 'Student Id', abbr: 'i');
  }

  @override
  void run() async {
    if (argResults?['id'] == null) {
      print('Por favor envie o Id do aluno com o comando --id=0 ou -i 0');
      return;
    }
    final id = int.parse(argResults?['id']);

    print('Aguarde, buscando dados...');
    final student = await repository.findById(id);

    print('---------------------------------------------------');
    print('Aluno ${student.name}:');
    print('---------------------------------------------------');
    print('Nome: ${student.name}');
    print('Idade: ${student.idade ?? 'não informado'}');
    print('Curso: ${student.name}');
    student.nomeCursos.forEach(print);
    print('Endereço');
    print('${student.endereco.rua} ${student.endereco.zipCode}');
  }
}
