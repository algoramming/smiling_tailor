import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../db/db.dart';
import '../../../utils/extensions/extensions.dart';
import '../../authentication/model/user.dart';
import '../../employee/model/employee.dart';
import '../../inventory/model/inventory.dart';
import '../../order/model/order.dart';
import '../../settings/model/measurement/measurement.dart';
import '../../settings/model/settings.model.dart';
import '../../vendor/model/vendor.dart';
import '../enum/trx.type.dart';

part 'transaction.ext.dart';

const pktbsTrxExpand = 'creator, updator';

class PktbsTrx {
  String toId;
  bool isGoods;
  String fromId;
  GLType toType;
  double amount;
  bool isActive;
  String voucher;
  TrxType trxType;
  GLType fromType;
  final String id;
  Measurement? unit;
  DateTime? updated;
  PktbsUser? updator;
  String? description;
  bool isSystemGenerated;
  final DateTime created;
  Map<String, dynamic> to;
  final PktbsUser creator;
  Map<String, dynamic> from;
  final String collectionId;
  final String collectionName;

  PktbsTrx({
    this.unit,
    this.updated,
    this.updator,
    this.description,
    required this.to,
    required this.id,
    required this.toId,
    required this.from,
    this.isGoods = false,
    required this.toType,
    required this.amount,
    required this.fromId,
    required this.created,
    required this.creator,
    required this.trxType,
    required this.voucher,
    required this.fromType,
    required this.isActive,
    required this.collectionId,
    required this.collectionName,
    this.isSystemGenerated = false,
  });

  factory PktbsTrx.fromJson(Map<String, dynamic> json) => PktbsTrx(
        id: json[_Json.id] as String,
        toId: json[_Json.toId] as String,
        fromId: json[_Json.fromId] as String,
        voucher: json[_Json.voucher] as String,
        to: json[_Json.to] as Map<String, dynamic>,
        toType: (json[_Json.toType] as String).glType,
        from: json[_Json.from] as Map<String, dynamic>,
        isGoods: json[_Json.isGoods] as bool? ?? false,
        description: json[_Json.description] as String?,
        isActive: json[_Json.isActive] as bool? ?? false,
        trxType: (json[_Json.trxType] as String).trxType,
        collectionId: json[_Json.collectionId] as String,
        fromType: (json[_Json.fromType] as String).glType,
        unit: (json[_Json.unit] as String?)?.getMeasurement,
        collectionName: json[_Json.collectionName] as String,
        amount: json[_Json.amount].toString().toDouble ?? 0.0,
        creator: PktbsUser.fromJson(json[_Json.expand][_Json.creator]),
        updated: json[_Json.updated] == null
            ? null
            : DateTime.parse(json[_Json.updated] as String).toLocal(),
        created: DateTime.parse(json[_Json.created] as String).toLocal(),
        updator: json[_Json.updator] == null || json[_Json.updator] == ''
            ? null
            : PktbsUser.fromJson(json[_Json.expand][_Json.updator]),
        isSystemGenerated: json[_Json.isSystemGenerated] as bool? ?? false,
      );

  factory PktbsTrx.fromRawJson(String str) =>
      PktbsTrx.fromJson(json.decode(str) as Map<String, dynamic>);

  @override
  String toString() =>
      'PktbsTrx(id: $id, created: $created, updated: $updated, creator: $creator, updator: $updator, collectionId: $collectionId, collectionName: $collectionName, fromId: $fromId, from: $from, fromType: $fromType, toId: $toId, to: $to, toType: $toType, amount: $amount, unit: $unit, isGoods: $isGoods, trxType: $trxType, description: $description, voucher: $voucher, isSystemGenerated: $isSystemGenerated, isActive: $isActive)';

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
  static const String to = 'to';
  static const String unit = 'unit';
  static const String from = 'from';
  static const String toId = 'to_id';
  static const String toType = 'toType';
  static const String amount = 'amount';
  static const String fromId = 'from_id';
  static const String expand = 'expand';
  static const String isGoods = 'isGoods';
  static const String trxType = 'trxType';
  static const String voucher = 'voucher';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String creator = 'creator';
  static const String updator = 'updator';
  static const String isActive = 'isActive';
  static const String fromType = 'fromType';
  static const collectionId = 'collectionId';
  static const collectionName = 'collectionName';
  static const String description = 'description';
  static const String isSystemGenerated = 'isSystemGenerated';
}
