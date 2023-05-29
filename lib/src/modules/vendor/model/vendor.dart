import 'dart:convert';

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
  double openingBalance;
  final DateTime created;
  final String collectionId;
  final String collectionName;

  PktbsVendor({
    this.updated,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.created,
    required this.description,
    required this.collectionId,
    required this.openingBalance,
    required this.collectionName,
  });

  // from json
  factory PktbsVendor.fromJson(Map<String, dynamic> json) {
    return PktbsVendor(
      id: json[_Json.id],
      name: json[_Json.name],
      email: json[_Json.email],
      phone: json[_Json.phone],
      address: json[_Json.address],
      description: json[_Json.description],
      collectionId: json[_Json.collectionId],
      collectionName: json[_Json.collectionName],
      created: DateTime.parse(json[_Json.created]),
      updated: json[_Json.updated] == null
          ? null
          : DateTime.parse(json[_Json.updated]),
      openingBalance: json[_Json.openingBalance].toString().toDouble ?? 0.0,
    );
  }

  // from raw json
  factory PktbsVendor.fromRawJson(String str) =>
      PktbsVendor.fromJson(json.decode(str));

  // to string
  @override
  String toString() =>
      'PktbsVendor(id: $id, name: $name, address: $address, description: $description, email: $email, phone: $phone, openingBalance: $openingBalance, created: $created, updated: $updated, collectionId: $collectionId, collectionName: $collectionName)';
}

class _Json {
  static const id = 'id';
  static const name = 'name';
  static const address = 'address';
  static const description = 'description';
  static const email = 'email';
  static const phone = 'phone';
  static const openingBalance = 'opening_balance';
  static const created = 'created';
  static const updated = 'updated';
  static const collectionId = 'collectionId';
  static const collectionName = 'collectionName';
}
