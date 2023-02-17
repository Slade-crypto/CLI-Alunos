import 'dart:convert';

import '../models/users_model.dart';
import 'package:http/http.dart' as http;

class StudentRepository {
  Future<List<Users>> findAll() async {
    final response = await http.get(Uri.parse('http://localhost:8080/students'));

    if (response.statusCode != 200) {
      throw Exception();
    }

    //Como vai ser retornado uma lista de estudantes, devemos fazer na mão
    //a conversão para map percorrendo a lista ao invés de usar nosso fromJson
    final responseData = jsonDecode(response.body);

    //Não esquecer de tipar o retorno da conversão para evitar erros
    return responseData.map<Users>((responseMap) => Users.fromMap(responseMap)).toList();
  }

  Future<Users> findById(int id) async {
    final response = await http.get(Uri.parse('http://localhost:8080/students/$id'));

    if (response.statusCode != 200) {
      throw Exception();
    }

    if (response.body == '{}') {
      throw Exception();
    }

    return Users.fromJson(response.body);
  }

  Future<void> insert(Users student) async {
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
  }

  Future<void> update(Users student) async {
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
  }

  Future<void> deleteById(int id) async {
    final response = await http.delete(Uri.parse('http://localhost:8080/students/$id'));

    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}
