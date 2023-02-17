import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../repositories/student_dio_repository.dart';

class DeleteCommand extends Command {
  final StudentDioRepository repository;

  @override
  String get description => 'Deletar estudante';

  @override
  String get name => 'delete';

  DeleteCommand(this.repository) {
    argParser.addOption('delete', help: 'Deletar estudante', abbr: 'd');
    argParser.addOption('id', help: 'Student Id', abbr: 'i');
  }

  @override
  void run() async {
    final id = int.tryParse(argResults?['id']);

    if (id == null) {
      print('Por favor informe um usuário para deleção');
      return;
    }

    print('Aguarde...');
    print('---------------------------');
    final student = await repository.findById(id);

    print('Deseja realmente excluir o estudante ${student.name}? (S ou N)');

    final confirmMessage = stdin.readLineSync();
    if (confirmMessage?.toLowerCase() == 's') {
      await repository.deleteById(id);
      print('usuario deletado com sucesso');
    } else {
      return;
    }
  }
}
