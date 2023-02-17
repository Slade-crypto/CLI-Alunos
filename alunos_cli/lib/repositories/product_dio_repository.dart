import 'package:dio/dio.dart';

import '../models/cursos_model.dart';

class ProductDioRepository {
  Future<Cursos> findByName(String name) async {
    try {
      var dio = Dio();

      final response = await dio.get(
        'http://localhost:8080/products',
        queryParameters: {
          'name': name,
        },
      );

      if (response.data.isEmpty) {
        throw Exception('produto não encontrado');
      }

      return Cursos.fromMap(response.data.first);
    } on DioError {
      throw Exception();
    }
  }
}
