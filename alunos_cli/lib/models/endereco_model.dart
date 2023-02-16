import 'dart:convert';

import 'telefone_model.dart';

import 'cidade_model.dart';

class Endereco {
  final String rua;
  final int numero;
  final String zipCode;
  final Cidade cidade;
  final Telefone telefone;
  Endereco({
    required this.rua,
    required this.numero,
    required this.zipCode,
    required this.cidade,
    required this.telefone,
  });

  Map<String, dynamic> toMap() {
    return {
      'street': rua,
      'number': numero,
      'zipCode': zipCode,
      'city': cidade.toMap(),
      'phone': telefone.toMap(),
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Endereco.fromMap(Map<String, dynamic> map) {
    return Endereco(
      rua: map['street'] ?? '',
      numero: map['number'] ?? 0,
      zipCode: map['zipCode'] ?? '',
      cidade: Cidade.fromMap(map['cidade'] ?? <String, dynamic>{}),
      telefone: Telefone.fromMap(map['phone'] ?? <String, dynamic>{}),
    );
  }
}
