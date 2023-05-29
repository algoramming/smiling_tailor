import 'dart:convert';

import '../../../utils/extensions/extensions.dart';

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

  factory PktbsEmployee.fromRawJson(String str) =>
      PktbsEmployee.fromJson(json.decode(str));

  @override
  String toString() =>
      'PktbsEmployee(name: $name, phone: $phone, email: $email, salary: $salary, address: $address, id: $id, updated: $updated, description: $description, created: $created, collectionId: $collectionId, collectionName: $collectionName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PktbsEmployee && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
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
