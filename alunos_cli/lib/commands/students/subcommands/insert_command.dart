// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/cidade_model.dart';
import '../../../models/endereco_model.dart';
import '../../../models/telefone_model.dart';
import '../../../models/users_model.dart';
import '../../../repositories/product_dio_repository.dart';
import '../../../repositories/student_dio_repository.dart';

class InsertCommand extends Command {
  final StudentDioRepository repository;
  final productsRepository = ProductDioRepository();

  @override
  String get description => 'Inserindo estudante';

  @override
  String get name => 'insert';

  InsertCommand(this.repository) {
    argParser.addOption('file', help: 'path do arquivo csv', abbr: 'f');
  }

  @override
  Future<void> run() async {
    print('Aguarde...');
    final filePath = argResults?['file'];
    final students = File(filePath).readAsLinesSync();
    print('---------------------------------------------');

    for (var student in students) {
      final studentData = student.split(';');
      final courseCsv = studentData[2].split(',').map((e) => e.trim()).toList();

      final courseFuture = courseCsv.map((c) async {
        final course = await productsRepository.findByName(c);
        course.isAluno = true;
        return course;
      }).toList();

      final courses = await Future.wait(courseFuture);

      final studentModel = Users(
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

      await repository.insert(studentModel);
    }
    print('-----------------------------');
    print('Aluno adicionado com sucesso');
  }
}
