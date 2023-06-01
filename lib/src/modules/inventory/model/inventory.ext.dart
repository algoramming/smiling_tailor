part of 'inventory.dart';

extension InventoryExtension on PktbsInventory {
  PktbsInventory copyWith({
    String? id,
    String? unit,
    String? title,
    int? quantity,
    double? amount,
    double? advance,
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
      advance: advance ?? this.advance,
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
        _Json.unit: unit,
        _Json.title: title,
        _Json.amount: amount,
        _Json.advance: advance,
        _Json.quantity: quantity,
        _Json.from: from.toJson(),
        _Json.description: description,
        _Json.creator: creator.toJson(),
        _Json.updator: updator?.toJson(),
        _Json.collectionId: collectionId,
        _Json.collectionName: collectionName,
        _Json.created: created.toUtc().toIso8601String(),
        _Json.updated: updated?.toUtc().toIso8601String(),
      };

  String toRawJson() => json.encode(toJson());

  String get createdDate =>
      appSettings.getDateTimeFormat.format(created.toLocal());

  String? get updatedDate => updated != null
      ? appSettings.getDateTimeFormat.format(updated!.toLocal())
      : null;

  Future<Measurement?> get measurement async =>
      await db.measurements.where().filter().nameEqualTo(unit).findFirst();
}
