import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/cidade_model.dart';
import '../../../models/endereco_model.dart';
import '../../../models/telefone_model.dart';
import '../../../models/users_model.dart';
import '../../../repositories/product_dio_repository.dart';
import '../../../repositories/student_dio_repository.dart';

class UpdateCommand extends Command {
  final StudentDioRepository repository;
  final productRepository = ProductDioRepository();

  @override
  String get description => 'Atualizar estudante';

  @override
  String get name => 'update';

  UpdateCommand(this.repository) {
    argParser.addOption('file', help: 'path do arquivo csv', abbr: 'f');
    argParser.addOption('id', help: 'Student Id', abbr: 'i');
  }

  @override
  Future<void> run() async {
    print('Aguarde...');
    final filePath = argResults?['file'];
    final id = argResults?['id'];

    if (id == null) {
      print('Por favor, informe o id com o comando --id=0 ou -i0');
      return;
    }

    final students = File(filePath).readAsLinesSync();
    print('Aguarde, atualizando dados do aluno...');
    print('---------------------------------------------');

    if (students.length > 1) {
      print('Por favor, informe somente um aluno no arquivo $filePath');
      return;
    } else if (students.isEmpty) {
      print('Por favor, informe um aluno no arquivo $filePath');
      return;
    }

    var student = students.first;

    final studentData = student.split(';');
    final courseCsv = studentData[2].split(',').map((e) => e.trim()).toList();

    final courseFuture = courseCsv.map((c) async {
      final course = await productRepository.findByName(c);
      course.isAluno = true;
      return course;
    }).toList();

    final courses = await Future.wait(courseFuture);

    final studentModel = Users(
      id: int.parse(id),
      name: studentData[0],
      idade: int.tryParse(studentData[1]),
      nomeCursos: courseCsv,
      cursos: courses,
      endereco: Endereco(
        rua: studentData[3],
        numero: int.parse(studentData[4]),
        zipCode: studentData[5],
        cidade: Cidade(
          id: 1,
          name: studentData[6],
        ),
        telefone: Telefone(
          ddd: int.parse(studentData[7]),
          numeroTelefone: studentData[8],
        ),
      ),
    );

    await repository.update(studentModel);

    print('-----------------------------');
    print('Aluno atualizado com sucesso');
  }
}
