import 'dart:convert';

import 'package:smiling_tailor/src/modules/vendor/model/vendor.dart';

import '../../../db/isar.dart';
import '../../authentication/model/user.dart';
import '../../settings/model/settings.model.dart';

part 'inventory.ext.dart';

class PktbsInventory {
  int quantity;
  String unit;
  String title;
  double amount;
  double advance;
  final String id;
  DateTime? updated;
  String? description;
  PktbsUser createdBy;
  PktbsUser? updatedBy;
  final DateTime created;
  PktbsVendor createdFrom;

  PktbsInventory({
    this.updated,
    this.updatedBy,
    this.description,
    required this.id,
    required this.unit,
    required this.title,
    required this.amount,
    required this.advance,
    required this.created,
    required this.quantity,
    required this.createdBy,
    required this.createdFrom,
  });

  factory PktbsInventory.fromJson(Map<String, dynamic> json) {
    return PktbsInventory(
      id: json[_Json.id],
      unit: json[_Json.unit],
      title: json[_Json.title],
      amount: json[_Json.amount],
      advance: json[_Json.advance],
      quantity: json[_Json.quantity],
      description: json[_Json.description],
      created: json[_Json.created].toDateTime(),
      updated: json[_Json.updated]?.toDateTime(),
      createdBy: PktbsUser.fromJson(json[_Json.expand][_Json.createdBy]),
      updatedBy: json[_Json.updatedBy] == null || json[_Json.updatedBy] == ''
          ? null
          : PktbsUser.fromJson(json[_Json.expand][_Json.updatedBy]),
      createdFrom: PktbsVendor.fromJson(json[_Json.expand][_Json.createdFrom]),
    );
  }

  factory PktbsInventory.fromRawJson(String str) =>
      PktbsInventory.fromJson(json.decode(str));

  @override
  String toString() => 'PktbsInventory{quantity: $quantity, unit: $unit, title: $title, amount: $amount, advance: $advance, id: $id, updated: $updated, description: $description, createdBy: $createdBy, updatedBy: $updatedBy, created: $created, createdFrom: $createdFrom}';

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
  static const String unit = 'unit';
  static const String title = 'title';
  static const String amount = 'amount';
  static const String expand = 'expand';
  static const String advance = 'advance';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String quantity = 'quantity';
  static const String createdBy = 'created_by';
  static const String updatedBy = 'updated_by';
  static const String description = 'description';
  static const String createdFrom = 'created_from';
}
