import 'dart:convert';

class Cidade {
  final int id;
  final String name;
  Cidade({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Cidade.fromMap(Map<String, dynamic> map) {
    return Cidade(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  factory Cidade.fromJson(String json) => Cidade.fromMap(jsonDecode(json));
}
