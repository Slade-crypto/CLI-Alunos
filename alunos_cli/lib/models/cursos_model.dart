// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Cursos {
  final int id;
  final String name;
  bool isAluno;
  Cursos({
    required this.id,
    required this.name,
    required this.isAluno,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isStudent': isAluno,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Cursos.fromMap(Map<String, dynamic> map) {
    return Cursos(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      isAluno: map['isStudent'] ?? false,
    );
  }

  factory Cursos.fromJson(String json) => Cursos.fromMap(jsonDecode(json));
}
