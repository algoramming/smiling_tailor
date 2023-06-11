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
        _Json.creator: creator.id,
        _Json.updator: updator?.id,
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
        _Json.expand: {
          _Json.creator: creator.toJson(),
          _Json.updator: updator?.toJson(),
        }
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

  String get fromName {
    switch (fromType) {
      case GLType.vendor:
        return '${PktbsVendor.fromJson(from).name} [Vendor]';
      case GLType.inventory:
        return '${PktbsInventory.fromJson(from).title} [Inventory]';
      case GLType.employee:
        return '${PktbsEmployee.fromJson(from).name} [Employee]';
      case GLType.order:
        return '${PktbsOrder.fromJson(from).customerName} [Order]';
      case GLType.user:
        return '${PktbsUser.fromJson(from).name} [User]';
      default:
        return '${PktbsUser.fromJson(from).name} [User]';
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

  String get toName {
    switch (toType) {
      case GLType.vendor:
        return '${PktbsVendor.fromJson(to).name} [Vendor]';
      case GLType.inventory:
        return '${PktbsInventory.fromJson(to).title} [Inventory]';
      case GLType.employee:
        return '${PktbsEmployee.fromJson(to).name} [Employee]';
      case GLType.order:
        return '${PktbsOrder.fromJson(to).customerName} [Order]';
      case GLType.user:
        return '${PktbsUser.fromJson(to).name} [User]';
      default:
        return '${PktbsUser.fromJson(to).name} [User]';
    }
  }

  String get createdDate =>
      appSettings.getDateTimeFormat.format(created.toLocal());

  String? get updatedDate => updated != null
      ? appSettings.getDateTimeFormat.format(updated!.toLocal())
      : null;

  Widget get modifiers => updator == null
      ? Tooltip(
          message: 'Created by ${creator.name} on $createdDate',
          child: creator.imageWidget,
        )
      : creator == updator
          ? Tooltip(
              message:
                  '${creator.name}\nCreated on $createdDate\nUpdated on $updatedDate',
              child: creator.imageWidget,
            )
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 7.0, 7.0),
                  child: Tooltip(
                    message: 'Created by ${creator.name} on $createdDate',
                    child: creator.imageWidget,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6.0, 6.0, 0.0, 0.0),
                  child: Tooltip(
                    message: 'Updated by ${updator!.name} on $updatedDate',
                    child: updator!.imageWidget,
                  ),
                ),
              ],
            );
}
