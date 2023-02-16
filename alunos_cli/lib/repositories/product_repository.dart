import 'dart:convert';

import '../models/cursos_model.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<Cursos> findByName(String name) async {
    final response = await http.get(Uri.parse('http://localhost:8080/products?name=$name'));

    if (response.statusCode != 200) {
      throw Exception();
    }

    final responseData = jsonDecode(response.body);

    if (responseData.isEmpty) {
      throw Exception('produto não encontrado');
    }

    return Cursos.fromMap(responseData.first);
  }
}
