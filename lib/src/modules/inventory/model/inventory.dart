import 'dart:convert';

import 'package:isar/isar.dart';

import '../../../db/isar.dart';
import '../../../utils/extensions/extensions.dart';
import '../../authentication/model/user.dart';
import '../../settings/model/measurement/measurement.dart';
import '../../settings/model/settings.model.dart';
import '../../vendor/model/vendor.dart';

part 'inventory.ext.dart';

class PktbsInventory {
  int quantity;
  String unit;
  String title;
  double amount;
  double advance;
  final String id;
  PktbsVendor from;
  DateTime? updated;
  PktbsUser? updator;
  String? description;
  final DateTime created;
  final PktbsUser creator;
  final String collectionId;
  final String collectionName;

  PktbsInventory({
    this.updated,
    this.updator,
    this.description,
    required this.id,
    required this.from,
    required this.unit,
    required this.title,
    required this.amount,
    required this.advance,
    required this.created,
    required this.creator,
    required this.quantity,
    required this.collectionId,
    required this.collectionName,
  });

  factory PktbsInventory.fromJson(Map<String, dynamic> json) {
    return PktbsInventory(
      id: json[_Json.id],
      unit: json[_Json.unit],
      title: json[_Json.title],
      description: json[_Json.description],
      collectionId: json[_Json.collectionId],
      collectionName: json[_Json.collectionName],
      quantity: json[_Json.quantity].toString().toInt ?? 0,
      amount: json[_Json.amount].toString().toDouble ?? 0.0,
      created: DateTime.parse(json[_Json.created]).toLocal(),
      advance: json[_Json.advance].toString().toDouble ?? 0.0,
      from: PktbsVendor.fromJson(json[_Json.expand][_Json.from]),
      creator: PktbsUser.fromJson(json[_Json.expand][_Json.creator]),
      updator: json[_Json.updator] == null || json[_Json.updator] == ''
          ? null
          : PktbsUser.fromJson(json[_Json.expand][_Json.updator]),
      updated: json[_Json.updated] == null || json[_Json.updated] == ''
          ? null
          : DateTime.parse(json[_Json.updated]).toLocal(),
    );
  }

  factory PktbsInventory.fromRawJson(String str) =>
      PktbsInventory.fromJson(json.decode(str));

  @override
  String toString() =>
      'PktbsInventory(id: $id, from: $from, unit: $unit, title: $title, amount: $amount, advance: $advance, created: $created, creator: $creator, updator: $updator, updated: $updated, quantity: $quantity, description: $description, collectionId: $collectionId, collectionName: $collectionName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PktbsInventory && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _Json {
  static const String id = 'id';
  static const String from = 'from';
  static const String unit = 'unit';
  static const String title = 'title';
  static const String amount = 'amount';
  static const String expand = 'expand';
  static const String advance = 'advance';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String creator = 'creator';
  static const String updator = 'updator';
  static const String quantity = 'quantity';
  static const collectionId = 'collectionId';
  static const collectionName = 'collectionName';
  static const String description = 'description';
}