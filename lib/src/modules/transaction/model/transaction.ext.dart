part of 'transaction.dart';

extension TrxExtension on PktbsTrx {
  PktbsTrx copyWith({
    String? id,
    GLType? type,
    String? glId,
    double? amount,
    DateTime? created,
    DateTime? updated,
    bool? isReceiveable,
    String? description,
    PktbsUser? updatedBy,
    PktbsUser? createdBy,
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
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      description: description ?? this.description,
      isReceiveable: isReceiveable ?? this.isReceiveable,
    );
  }

  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.gl: gl,
        _Json.glId: glId,
        _Json.amount: amount,
        _Json.type: type.title,
        _Json.description: description,
        _Json.isReceiveable: isReceiveable,
        _Json.createdBy: createdBy.toJson(),
        _Json.updatedBy: updatedBy?.toJson(),
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
        // return PktbsInventory.fromJson(gl);
        return null;
      case GLType.unknown:
        return null;
      default:
        return null;
    }
  }

  String get createdDate => appSettings.getDateTimeFormat.format(created);

  String get updatedDate => appSettings.getDateTimeFormat.format(updated!);
}