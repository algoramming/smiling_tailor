import 'dart:convert';

import '../../authentication/model/user.dart';
import '../../settings/model/settings.model.dart';
import '../enum/trx.type.dart';
import '../../../utils/extensions/extensions.dart';

import '../../../db/isar.dart';
import '../../employee/model/employee.dart';
import '../../vendor/model/vendor.dart';

part 'transaction.ext.dart';

class PktbsTrx {
  double due;
  String glId;
  GLType type;
  double amount;
  final String id;
  DateTime? updated;
  String? description;
  PktbsUser createdBy;
  PktbsUser? updatedBy;
  final DateTime created;
  Map<String, dynamic> gl;

  PktbsTrx({
    this.due = 0.0,
    this.updated,
    this.description,
    required this.gl,
    required this.id,
    required this.type,
    required this.glId,
    required this.amount,
    required this.created,
    required this.createdBy,
    required this.updatedBy,
  });

  factory PktbsTrx.fromJson(Map<String, dynamic> json) => PktbsTrx(
        id: json[_Json.id],
        glId: json[_Json.glId],
        type: (json[_Json.type] as String).glType,
        gl: json[_Json.gl] as Map<String, dynamic>,
        created: DateTime.parse(json[_Json.created]),
        description: json[_Json.description] as String?,
        due: json[_Json.due].toString().toDouble ?? 0.0,
        updatedBy: json[_Json.updatedBy] == null || json[_Json.updatedBy] == ''
            ? null
            : PktbsUser.fromJson(json[_Json.expand][_Json.updatedBy]),
        createdBy: PktbsUser.fromJson(json[_Json.expand][_Json.createdBy]),
        amount: json[_Json.amount].toString().toDouble ?? 0.0,
        updated: json[_Json.updated] == null
            ? null
            : DateTime.parse(json[_Json.updated]),
      );

  factory PktbsTrx.fromRawJson(String str) =>
      PktbsTrx.fromJson(json.decode(str) as Map<String, dynamic>);

  @override
  String toString() =>
      'PktbsTrx(glId: $glId, type: $type, amount: $amount, due: $due id: $id, updated: $updated, description: $description, createdBy: $createdBy, updatedBy: $updatedBy, created: $created, gl: $gl)';
}

class _Json {
  static const String gl = 'gl';
  static const String id = 'id';
  static const String due = 'due';
  static const String type = 'type';
  static const String glId = 'gl_id';
  static const String expand = 'expand';
  static const String amount = 'amount';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String createdBy = 'created_by';
  static const String updatedBy = 'updated_by';
  static const String description = 'description';
}
