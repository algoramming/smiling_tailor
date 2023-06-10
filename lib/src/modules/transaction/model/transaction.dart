import 'dart:convert';

import 'package:flutter/material.dart';

import '../../settings/model/measurement/measurement.dart';

import '../../../db/isar.dart';
import '../../../utils/extensions/extensions.dart';
import '../../authentication/model/user.dart';
import '../../employee/model/employee.dart';
import '../../inventory/model/inventory.dart';
import '../../order/model/order.dart';
import '../../settings/model/settings.model.dart';
import '../../vendor/model/vendor.dart';
import '../enum/trx.type.dart';

part 'transaction.ext.dart';

const pktbsTrxExpand = 'creator, updator';

class PktbsTrx {
  final String id;
  final DateTime created;
  DateTime? updated;
  final PktbsUser creator;
  PktbsUser? updator;
  final String collectionId;
  final String collectionName;
  //
  String fromId;
  Map<String, dynamic> from;
  GLType fromType;
  //
  String toId;
  Map<String, dynamic> to;
  GLType toType;
  //
  double amount;
  Measurement? unit;
  bool isGoods;
  TrxType trxType;
  String? description;
  bool isSystemGenerated;

  PktbsTrx({
    required this.id,
    required this.created,
    this.updated,
    required this.creator,
    this.updator,
    required this.collectionId,
    required this.collectionName,
    //
    required this.fromId,
    required this.from,
    required this.fromType,
    //
    required this.toId,
    required this.to,
    required this.toType,
    //
    required this.amount,
    this.unit,
    this.isGoods = false,
    required this.trxType,
    this.description,
    this.isSystemGenerated = false,
  });

  factory PktbsTrx.fromJson(Map<String, dynamic> json) => PktbsTrx(
        id: json[_Json.id] as String,
        created: DateTime.parse(json[_Json.created] as String),
        updated: json[_Json.updated] == null
            ? null
            : DateTime.parse(json[_Json.updated] as String),
        creator: PktbsUser.fromJson(json[_Json.expand][_Json.creator]),
        updator: json[_Json.updator] == null || json[_Json.updator] == ''
            ? null
            : PktbsUser.fromJson(json[_Json.expand][_Json.updator]),
        collectionId: json[_Json.collectionId] as String,
        collectionName: json[_Json.collectionName] as String,
        //
        fromId: json[_Json.fromId] as String,
        from: json[_Json.from] as Map<String, dynamic>,
        fromType: (json[_Json.fromType] as String).glType,
        //
        toId: json[_Json.toId] as String,
        to: json[_Json.to] as Map<String, dynamic>,
        toType: (json[_Json.toType] as String).glType,
        //
        amount: json[_Json.amount].toString().toDouble ?? 0.0,
        unit: (json[_Json.unit] as String?)?.getMeasurement,
        isGoods: json[_Json.isGoods] as bool? ?? false,
        trxType: (json[_Json.trxType] as String).trxType,
        description: json[_Json.description] as String?,
        isSystemGenerated: json[_Json.isSystemGenerated] as bool? ?? false,
      );
  // id: json[_Json.id],
  // glId: json[_Json.glId],
  // collectionId: json[_Json.collectionId],
  // updated: json[_Json.updated] == null
  //     ? null
  //     : DateTime.parse(json[_Json.updated]),
  // collectionName: json[_Json.collectionName],
  // type: (json[_Json.type] as String).glType,
  // gl: json[_Json.gl] as Map<String, dynamic>,
  // created: DateTime.parse(json[_Json.created]),
  // description: json[_Json.description] as String?,
  // amount: json[_Json.amount].toString().toDouble ?? 0.0,
  // creator: PktbsUser.fromJson(json[_Json.expand][_Json.creator]),
  // updator: json[_Json.updator] == null || json[_Json.updator] == ''
  //     ? null
  //     : PktbsUser.fromJson(json[_Json.expand][_Json.updator]),
  // );

  factory PktbsTrx.fromRawJson(String str) =>
      PktbsTrx.fromJson(json.decode(str) as Map<String, dynamic>);

  @override
  String toString() =>
      'PktbsTrx(id: $id, created: $created, updated: $updated, creator: $creator, updator: $updator, collectionId: $collectionId, collectionName: $collectionName, fromId: $fromId, from: $from, fromType: $fromType, toId: $toId, to: $to, toType: $toType, amount: $amount, unit: $unit, isGoods: $isGoods, trxType: $trxType, description: $description, isSystemGenerated: $isSystemGenerated)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PktbsTrx && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _Json {
  static const String id = 'id';
  static const String expand = 'expand';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String creator = 'creator';
  static const String updator = 'updator';
  static const collectionId = 'collectionId';
  static const collectionName = 'collectionName';
  //
  static const String fromId = 'from_id';
  static const String from = 'from';
  static const String fromType = 'fromType';
  //
  static const String toId = 'to_id';
  static const String to = 'to';
  static const String toType = 'toType';
  //
  static const String amount = 'amount';
  static const String unit = 'unit';
  static const String isGoods = 'isGoods';
  static const String trxType = 'trxType';
  static const String description = 'description';
  static const String isSystemGenerated = 'isSystemGenerated';
}
