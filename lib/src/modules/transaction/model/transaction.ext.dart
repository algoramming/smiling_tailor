part of 'transaction.dart';

extension TrxExtension on PktbsTrx {
  PktbsTrx copyWith({
    String? id,
    String? toId,
    bool? isGoods,
    GLType? toType,
    double? amount,
    String? fromId,
    String? voucher,
    GLType? fromType,
    TrxType? trxType,
    Measurement? unit,
    DateTime? created,
    DateTime? updated,
    PktbsUser? creator,
    PktbsUser? updator,
    String? description,
    String? collectionId,
    String? collectionName,
    bool? isSystemGenerated,
    Map<String, dynamic>? to,
    Map<String, dynamic>? from,
  }) {
    return PktbsTrx(
      id: id ?? this.id,
      to: to ?? this.to,
      from: from ?? this.from,
      toId: toId ?? this.toId,
      unit: unit ?? this.unit,
      toType: toType ?? this.toType,
      amount: amount ?? this.amount,
      fromId: fromId ?? this.fromId,
      isGoods: isGoods ?? this.isGoods,
      voucher: voucher ?? this.voucher,
      trxType: trxType ?? this.trxType,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      creator: creator ?? this.creator,
      updator: updator ?? this.updator,
      fromType: fromType ?? this.fromType,
      description: description ?? this.description,
      collectionId: collectionId ?? this.collectionId,
      collectionName: collectionName ?? this.collectionName,
      isSystemGenerated: isSystemGenerated ?? this.isSystemGenerated,
    );
  }

  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.to: to,
        _Json.from: from,
        _Json.toId: toId,
        _Json.fromId: fromId,
        _Json.amount: amount,
        _Json.unit: unit?.name,
        _Json.isGoods: isGoods,
        _Json.voucher: voucher,
        _Json.creator: creator.id,
        _Json.updator: updator?.id,
        _Json.toType: toType.title,
        _Json.trxType: trxType.title,
        _Json.fromType: fromType.title,
        _Json.description: description,
        _Json.collectionId: collectionId,
        _Json.collectionName: collectionName,
        _Json.created: created.toIso8601String(),
        _Json.updated: updated?.toIso8601String(),
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
