import 'dart:convert';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../transaction/enum/trx.type.dart';

part 'user.ext.dart';

class PktbsUser {
  String name;
  bool verified;
  String? avatar;
  final String id;
  DateTime? updated;
  final String email;
  bool emailVisibility;
  final String username;
  final DateTime created;
  final String collectionId;
  final String collectionName;

  PktbsUser({
    this.updated,
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    required this.created,
    required this.verified,
    required this.username,
    required this.collectionId,
    required this.collectionName,
    required this.emailVisibility,
  });

  // from json
  factory PktbsUser.fromJson(Map<String, dynamic> json) {
    return PktbsUser(
      id: json[_Json.id],
      name: json[_Json.name],
      email: json[_Json.email],
      avatar: json[_Json.avatar],
      verified: json[_Json.verified],
      username: json[_Json.username],
      collectionId: json[_Json.collectionId],
      collectionName: json[_Json.collectionName],
      emailVisibility: json[_Json.emailVisibility],
      created: DateTime.parse(json[_Json.created]),
      updated: json[_Json.updated] == null
          ? null
          : DateTime.parse(json[_Json.updated]),
    );
  }

  // from raw json
  factory PktbsUser.fromRawJson(String str) =>
      PktbsUser.fromJson(json.decode(str));

  // to string
  @override
  String toString() =>
      'PktbsUser(id: $id, name: $name, email: $email, avatar: $avatar, created: $created, updated: $updated, verified: $verified, username: $username, collectionId: $collectionId, collectionName: $collectionName, emailVisibility: $emailVisibility)';
}

class _Json {
  static const id = 'id';
  static const name = 'name';
  static const email = 'email';
  static const avatar = 'avatar';
  static const created = 'created';
  static const updated = 'updated';
  static const username = 'username';
  static const verified = 'verified';
  static const collectionId = 'collectionId';
  static const collectionName = 'collectionName';
  static const emailVisibility = 'emailVisibility';
}
