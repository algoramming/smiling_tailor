part of 'transaction.dart';

extension TrxExtension on PktbsTrx {
  PktbsTrx copyWith({
    String? id,
    double? due,
    GLType? type,
    String? glId,
    double? amount,
    DateTime? created,
    DateTime? updated,
    PktbsUser? updator,
    PktbsUser? creator,
    bool? isReceiveable,
    String? description,
    String? collectionId,
    String? collectionName,
    Map<String, dynamic>? gl,
  }) {
    return PktbsTrx(
      gl: gl ?? this.gl,
      id: id ?? this.id,
      type: type ?? this.type,
      glId: glId ?? this.glId,
      amount: amount ?? this.amount,
      updated: updated ?? this.updated,
      created: created ?? this.created,
      creator: creator ?? this.creator,
      updator: updator ?? this.updator,
      description: description ?? this.description,
      collectionId: collectionId ?? this.collectionId,
      collectionName: collectionName ?? this.collectionName,
    );
  }

  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.gl: gl,
        _Json.glId: glId,
        _Json.amount: amount,
        _Json.type: type.title,
        _Json.description: description,
        _Json.creator: creator.toJson(),
        _Json.updator: updator?.toJson(),
        _Json.collectionId: collectionId,
        _Json.collectionName: collectionName,
        _Json.created: created.toIso8601String(),
        _Json.updated: updated?.toIso8601String(),
      };

  String toRawJson() => json.encode(toJson());

  Object? getGLObject() {
    switch (type) {
      case GLType.vendor:
        return PktbsVendor.fromJson(gl);
      case GLType.employee:
        return PktbsEmployee.fromJson(gl);
      case GLType.inventory:
        return PktbsInventory.fromJson(gl);
      case GLType.unknown:
        return null;
      default:
        return null;
    }
  }

  String get createdDate =>
      appSettings.getDateTimeFormat.format(created.toLocal());

  String? get updatedDate => updated != null
      ? appSettings.getDateTimeFormat.format(updated!.toLocal())
      : null;
}
