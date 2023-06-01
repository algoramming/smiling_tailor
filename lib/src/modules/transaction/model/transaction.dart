import 'dart:convert';

import '../../../db/isar.dart';
import '../../../utils/extensions/extensions.dart';
import '../../authentication/model/user.dart';
import '../../employee/model/employee.dart';
import '../../inventory/model/inventory.dart';
import '../../settings/model/settings.model.dart';
import '../../vendor/model/vendor.dart';
import '../enum/trx.type.dart';

part 'transaction.ext.dart';

class PktbsTrx {
  double due;
  String glId;
  GLType type;
  double amount;
  final String id;
  DateTime? updated;
  PktbsUser? updator;
  String? description;
  final DateTime created;
  Map<String, dynamic> gl;
  final PktbsUser creator;
  final String collectionId;
  final String collectionName;

  PktbsTrx({
    this.updated,
    this.due = 0.0,
    this.description,
    required this.gl,
    required this.id,
    required this.type,
    required this.glId,
    required this.amount,
    required this.created,
    required this.creator,
    required this.updator,
    required this.collectionId,
    required this.collectionName,
  });

  factory PktbsTrx.fromJson(Map<String, dynamic> json) => PktbsTrx(
        id: json[_Json.id],
        glId: json[_Json.glId],
        collectionId: json[_Json.collectionId],
        updated: json[_Json.updated] == null
            ? null
            : DateTime.parse(json[_Json.updated]),
        collectionName: json[_Json.collectionName],
        type: (json[_Json.type] as String).glType,
        gl: json[_Json.gl] as Map<String, dynamic>,
        created: DateTime.parse(json[_Json.created]),
        description: json[_Json.description] as String?,
        due: json[_Json.due].toString().toDouble ?? 0.0,
        amount: json[_Json.amount].toString().toDouble ?? 0.0,
        creator: PktbsUser.fromJson(json[_Json.expand][_Json.creator]),
        updator: json[_Json.updator] == null || json[_Json.updator] == ''
            ? null
            : PktbsUser.fromJson(json[_Json.expand][_Json.updator]),
      );

  factory PktbsTrx.fromRawJson(String str) =>
      PktbsTrx.fromJson(json.decode(str) as Map<String, dynamic>);

  @override
  String toString() =>
      'PktbsTrx(due: $due, glId: $glId, type: $type, amount: $amount, id: $id, updated: $updated, updator: $updator, description: $description, created: $created, gl: $gl, creator: $creator, collectionId: $collectionId, collectionName: $collectionName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PktbsTrx && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
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
  static const String creator = 'creator';
  static const String updator = 'updator';
  static const collectionId = 'collectionId';
  static const collectionName = 'collectionName';
  static const String description = 'description';
}
