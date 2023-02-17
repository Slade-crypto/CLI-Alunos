import 'package:dio/dio.dart';

import '../models/users_model.dart';
import 'package:http/http.dart' as http;

class StudentDioRepository {
  Future<List<Users>> findAll() async {
    try {
      final response = await Dio().get('http://localhost:8080/students');

      //Não esquecer de tipar o retorno da conversão para evitar erros
      return response.data.map<Users>((responseMap) => Users.fromMap(responseMap)).toList();
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<Users> findById(int id) async {
    try {
      final result = await Dio().get('http://localhost:8080/students/$id');

      if (result.data == null) {
        throw Exception();
      }

      return Users.fromMap(result.data);
    } on DioError {
      throw Exception();
    }
  }

  Future<void> insert(Users student) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/students'),
        body: student.toJson(),
        headers: {
          'content-type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception();
      }
    } on DioError {
      throw Exception();
    }
  }

  Future<void> update(Users student) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:8080/students/${student.id}'),
        body: student.toJson(),
        headers: {
          'content-type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception();
      }
    } on DioError {
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    try {
      final response = await http.delete(Uri.parse('http://localhost:8080/students/$id'));

      if (response.statusCode != 200) {
        throw Exception();
      }
    } on DioError {
      throw Exception();
    }
  }
}
