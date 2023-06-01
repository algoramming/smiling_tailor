import 'dart:convert';
import 'package:smiling_tailor/src/modules/authentication/model/user.dart';
import 'package:smiling_tailor/src/modules/settings/model/settings.model.dart';
import '../../../db/isar.dart';
import '../../../utils/extensions/extensions.dart';
part 'vendor.ext.dart';

class PktbsVendor {
  String name;
  String phone;
  String? email;
  String address;
  final String id;
  DateTime? updated;
  String description;
  PktbsUser? updator;
  double openingBalance;
  final DateTime created;
  final PktbsUser creator;
  final String collectionId;
  final String collectionName;

  PktbsVendor({
    this.updator,
    this.updated,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.created,
    required this.creator,
    required this.description,
    required this.collectionId,
    required this.openingBalance,
    required this.collectionName,
  });

  factory PktbsVendor.fromJson(Map<String, dynamic> json) {
    return PktbsVendor(
      id: json[_Json.id],
      name: json[_Json.name],
      email: json[_Json.email],
      phone: json[_Json.phone],
      address: json[_Json.address],
      description: json[_Json.description],
      collectionId: json[_Json.collectionId],
      updated: json[_Json.updated] == null
          ? null
          : DateTime.parse(json[_Json.updated]),
      collectionName: json[_Json.collectionName],
      created: DateTime.parse(json[_Json.created]),
      creator: PktbsUser.fromJson(json[_Json.expand][_Json.creator]),
      updator: json[_Json.updator] == null || json[_Json.updator] == ''
          ? null
          : PktbsUser.fromJson(json[_Json.expand][_Json.updator]),
      openingBalance: json[_Json.openingBalance].toString().toDouble ?? 0.0,
    );
  }

  factory PktbsVendor.fromRawJson(String str) =>
      PktbsVendor.fromJson(json.decode(str));

  @override
  String toString() =>
      'PktbsVendor(name: $name, phone: $phone, email: $email, address: $address, id: $id, updated: $updated, description: $description, updator: $updator, openingBalance: $openingBalance, created: $created, creator: $creator, collectionId: $collectionId, collectionName: $collectionName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PktbsVendor && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

}

class _Json {
  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';
  static const String phone = 'phone';
  static const String expand = 'expand';
  static const String address = 'address';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String creator = 'creator';
  static const String updator = 'updator';
  static const String description = 'description';
  static const String collectionId = 'collectionId';
  static const String collectionName = 'collectionName';
  static const String openingBalance = 'opening_balance';
}
