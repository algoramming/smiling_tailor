part of 'user.dart';

extension PktbsUserExtension on PktbsUser {
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

  String toRawJson() => json.encode(toJson());

  String? get imageUrl => avatar == null || avatar == ''
      ? null
      : '${baseUrl}api/files/$collectionId/$id/$avatar/';

  GLType get glType => GLType.user;

  Widget get imageWidget => Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: kPrimaryColor, width: 1.5),
              ),
              child: ClipRRect(
                borderRadius: borderRadius45,
                child: imageUrl == null
                    ? Container(
                        color: kPrimaryColor.withOpacity(0.4),
                        child: FittedBox(
                          child: Text(
                            '${name.split(' ').first.split('').first}${name.split(' ').last.split('').first}',
                            style: const TextStyle(color: kPrimaryColor),
                          ),
                        ),
                      )
                    : FadeInImage(
                        placeholder:
                            const AssetImage('assets/gifs/loading.gif'),
                        image: NetworkImage(imageUrl!),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        ],
      );
}
