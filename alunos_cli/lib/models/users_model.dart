// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'cursos_model.dart';
import 'endereco_model.dart';

class Users {
  final int? id;
  final String name;
  final int? idade;
  final List<String> nomeCursos;
  final List<Cursos> cursos;
  final Endereco endereco;
  Users({
    this.id,
    required this.name,
    this.idade,
    required this.nomeCursos,
    required this.cursos,
    required this.endereco,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'id': id,
      'name': name,
      'nameCourses': nomeCursos,
      'courses': cursos.map((cursosMap) => cursosMap.toMap()).toList(),
      'address': endereco.toMap(),
    };
    if (idade != null) {
      map['idade'] = idade;
    }
    return map;
  }

  String toJson() => jsonEncode(toMap());

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      idade: map['age'],
      nomeCursos: List<String>.from(map['nameCourses'] ?? <String>[]),
      cursos: map['courses'].map<Cursos>((cursosMap) => Cursos.fromMap(cursosMap)).toList() ?? <Cursos>[],
      endereco: Endereco.fromMap(map['address'] ?? <String, dynamic>{}),
    );
  }

  factory Users.fromJson(String json) => Users.fromMap(jsonDecode(json));
}
