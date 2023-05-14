import 'dart:convert';

import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

part 'employee.ext.dart';

class PktbsEmployee {
  String name;
  String phone;
  String? email;
  double salary;
  String address;
  final String id;
  DateTime? updated;
  String description;
  final DateTime created;
  final String collectionId;
  final String collectionName;

  PktbsEmployee({
    this.email,
    this.updated,
    required this.id,
    required this.name,
    required this.phone,
    required this.salary,
    required this.created,
    required this.address,
    required this.description,
    required this.collectionId,
    required this.collectionName,
  });

  factory PktbsEmployee.fromJson(Map<String, dynamic> json) => PktbsEmployee(
        id: json[_Json.id],
        name: json[_Json.name],
        email: json[_Json.email],
        phone: json[_Json.phone],
        address: json[_Json.address],
        description: json[_Json.description],
        collectionId: json[_Json.collectionId],
        collectionName: json[_Json.collectionName],
        created: DateTime.parse(json[_Json.created]),
        updated: json[_Json.updated] != null
            ? DateTime.parse(json[_Json.updated])
            : null,
        salary: json[_Json.salary].toString().toDouble ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.name: name,
        _Json.email: email,
        _Json.phone: phone,
        _Json.salary: salary,
        _Json.address: address,
        _Json.description: description,
        _Json.collectionId: collectionId,
        _Json.collectionName: collectionName,
        _Json.created: created.toIso8601String(),
        _Json.updated: updated?.toIso8601String(),
      };

  String toRawJson() => json.encode(toJson());
}

class _Json {
  static const id = 'id';
  static const name = 'name';
  static const email = 'email';
  static const phone = 'phone';
  static const salary = 'salary';
  static const address = 'address';
  static const created = 'created';
  static const updated = 'updated';
  static const description = 'description';
  static const collectionId = 'collectionId';
  static const collectionName = 'collectionName';
}
