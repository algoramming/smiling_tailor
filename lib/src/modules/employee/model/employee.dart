import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../db/db.dart';
import '../../../utils/extensions/extensions.dart';
import '../../authentication/model/user.dart';
import '../../settings/model/settings.model.dart';
import '../../transaction/enum/trx.type.dart';

part 'employee.ext.dart';

const pktbsEmployeeExpand = 'creator, updator';

class PktbsEmployee {
  String name;
  String phone;
  String? email;
  double salary;
  String address;
  final String id;
  DateTime? updated;
  String description;
  PktbsUser? updator;
  final DateTime created;
  final PktbsUser creator;
  final String collectionId;
  final String collectionName;

  PktbsEmployee({
    this.email,
    this.updated,
    this.updator,
    required this.id,
    required this.name,
    required this.phone,
    required this.salary,
    required this.created,
    required this.address,
    required this.creator,
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
        updated: json[_Json.updated] != null
            ? DateTime.parse(json[_Json.updated]).toLocal()
            : null,
        salary: json[_Json.salary].toString().toDouble ?? 0.0,
        created: DateTime.parse(json[_Json.created]).toLocal(),
        creator: PktbsUser.fromJson(json[_Json.expand][_Json.creator]),
        updator: json[_Json.updator] == null || json[_Json.updator] == ''
            ? null
            : PktbsUser.fromJson(json[_Json.expand][_Json.updator]),
      );

  factory PktbsEmployee.fromRawJson(String str) =>
      PktbsEmployee.fromJson(json.decode(str));

  @override
  String toString() =>
      'PktbsEmployee(id: $id, name: $name, email: $email, phone: $phone, address: $address, created: $created, updated: $updated, salary: $salary, description: $description, updator: $updator, creator: $creator, collectionId: $collectionId, collectionName: $collectionName)';

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
  static const expand = 'expand';
  static const salary = 'salary';
  static const address = 'address';
  static const created = 'created';
  static const updated = 'updated';
  static const creator = 'creator';
  static const updator = 'updator';
  static const description = 'description';
  static const collectionId = 'collectionId';
  static const collectionName = 'collectionName';
}
