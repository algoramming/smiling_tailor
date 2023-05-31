part of 'user.dart';

extension PktbsUserExtension on PktbsUser {
  // copywith function
  PktbsUser copyWith({
    String? id,
    String? name,
    String? email,
    bool? verified,
    String? avatar,
    String? username,
    DateTime? created,
    DateTime? updated,
    String? collectionId,
    bool? emailVisibility,
    String? collectionName,
  }) {
    return PktbsUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      verified: verified ?? this.verified,
      username: username ?? this.username,
      collectionId: collectionId ?? this.collectionId,
      collectionName: collectionName ?? this.collectionName,
      emailVisibility: emailVisibility ?? this.emailVisibility,
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.name: name,
        _Json.email: email,
        _Json.avatar: avatar,
        _Json.verified: verified,
        _Json.username: username,
        _Json.collectionId: collectionId,
        _Json.collectionName: collectionName,
        _Json.emailVisibility: emailVisibility,
        _Json.created: created.toIso8601String(),
        _Json.updated: updated?.toIso8601String(),
      };

  // to raw json
  String toRawJson() => json.encode(toJson());

  // get Image Url
  String? get imageUrl => avatar == null || avatar == ''
      ? null
      : '${baseUrl}api/files/$collectionId/$id/$avatar/';
}
