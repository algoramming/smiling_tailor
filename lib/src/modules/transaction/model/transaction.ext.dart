part of 'transaction.dart';

extension TrxExtension on PktbsTrx {
  // copywith
  PktbsTrx copyWith({
    String? id,
    DateTime? created,
    DateTime? updated,
    PktbsUser? creator,
    PktbsUser? updator,
    String? collectionId,
    String? collectionName,
    String? fromId,
    Map<String, dynamic>? from,
    GLType? fromType,
    String? toId,
    Map<String, dynamic>? to,
    GLType? toType,
    double? amount,
    Measurement? unit,
    bool? isGoods,
    TrxType? trxType,
    String? description,
    bool? isSystemGenerated,
  }) {
    return PktbsTrx(
      id: id ?? this.id,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      creator: creator ?? this.creator,
      updator: updator ?? this.updator,
      collectionId: collectionId ?? this.collectionId,
      collectionName: collectionName ?? this.collectionName,
      fromId: fromId ?? this.fromId,
      from: from ?? this.from,
      fromType: fromType ?? this.fromType,
      toId: toId ?? this.toId,
      to: to ?? this.to,
      toType: toType ?? this.toType,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      isGoods: isGoods ?? this.isGoods,
      trxType: trxType ?? this.trxType,
      description: description ?? this.description,
      isSystemGenerated: isSystemGenerated ?? this.isSystemGenerated,
    );
  }

  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.created: created.toIso8601String(),
        _Json.updated: updated?.toIso8601String(),
        _Json.creator: creator.toJson(),
        _Json.updator: updator?.toJson(),
        _Json.collectionId: collectionId,
        _Json.collectionName: collectionName,
        _Json.fromId: fromId,
        _Json.from: from,
        _Json.fromType: fromType.title,
        _Json.toId: toId,
        _Json.to: to,
        _Json.toType: toType.title,
        _Json.amount: amount,
        _Json.unit: unit?.name,
        _Json.isGoods: isGoods,
        _Json.trxType: trxType.title,
        _Json.description: description,
        _Json.isSystemGenerated: isSystemGenerated,
      };

  String toRawJson() => json.encode(toJson());

  Object getFromObject() {
    switch (fromType) {
      case GLType.vendor:
        return PktbsVendor.fromJson(from);
      case GLType.inventory:
        return PktbsInventory.fromJson(from);
      case GLType.employee:
        return PktbsEmployee.fromJson(from);
      case GLType.order:
        return PktbsOrder.fromJson(from);
      case GLType.user:
        return PktbsUser.fromJson(from);
      default:
        return PktbsUser.fromJson(from);
    }
  }

  Object getToObject() {
    switch (toType) {
      case GLType.vendor:
        return PktbsVendor.fromJson(to);
      case GLType.inventory:
        return PktbsInventory.fromJson(to);
      case GLType.employee:
        return PktbsEmployee.fromJson(to);
      case GLType.order:
        return PktbsOrder.fromJson(to);
      case GLType.user:
        return PktbsUser.fromJson(to);
      default:
        return PktbsUser.fromJson(to);
    }
  }

  String get createdDate =>
      appSettings.getDateTimeFormat.format(created.toLocal());

  String? get updatedDate => updated != null
      ? appSettings.getDateTimeFormat.format(updated!.toLocal())
      : null;
}
