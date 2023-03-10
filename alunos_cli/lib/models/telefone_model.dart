import 'dart:convert';

class Telefone {
  final int ddd;
  final String numeroTelefone;
  Telefone({
    required this.ddd,
    required this.numeroTelefone,
  });

  Map<String, dynamic> toMap() {
    return {
      'ddd': ddd,
      'phone': numeroTelefone,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Telefone.fromMap(Map<String, dynamic> map) {
    return Telefone(
      ddd: map['ddd'] ?? 0,
      numeroTelefone: map['phone'] ?? '',
    );
  }

  factory Telefone.fromJson(String json) => Telefone.fromMap(jsonDecode(json));
}
