part of 'inventory.dart';

extension InventoryExtension on PktbsInventory {
  PktbsInventory copyWith({
    String? id,
    String? title,
    int? quantity,
    double? amount,
    Measurement? unit,
    PktbsVendor? from,
    DateTime? created,
    DateTime? updated,
    PktbsUser? creator,
    PktbsUser? updator,
    String? description,
    String? collectionId,
    String? collectionName,
  }) {
    return PktbsInventory(
      id: id ?? this.id,
      unit: unit ?? this.unit,
      from: from ?? this.from,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      creator: creator ?? this.creator,
      updator: updator ?? this.updator,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      collectionId: collectionId ?? this.collectionId,
      collectionName: collectionName ?? this.collectionName,
    );
  }

  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.title: title,
        _Json.amount: amount,
        _Json.unit: unit.name,
        _Json.quantity: quantity,
        _Json.from: from.id,
        _Json.description: description,
        _Json.creator: creator.id,
        _Json.updator: updator?.id,
        _Json.collectionId: collectionId,
        _Json.collectionName: collectionName,
        _Json.created: created.toUtc().toIso8601String(),
        _Json.updated: updated?.toUtc().toIso8601String(),
        _Json.expand: {
          _Json.from: from.toJson(),
          _Json.creator: creator.toJson(),
          if (updator != null) _Json.updator: updator!.toJson(),
        }
      };

  String toRawJson() => json.encode(toJson());

  String get createdDate =>
      appSettings.getDateTimeFormat.format(created.toLocal());

  String? get updatedDate => updated != null
      ? appSettings.getDateTimeFormat.format(updated!.toLocal())
      : null;

  GLType get glType => GLType.inventory;

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
