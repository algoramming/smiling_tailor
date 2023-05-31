part of 'inventory.dart';

extension InventoryExtension on PktbsInventory {

  // copywith
  PktbsInventory copyWith({
    String? id,
    String? unit,
    String? title,
    int? quantity,
    double? amount,
    double? advance,
    DateTime? created,
    DateTime? updated,
    String? description,
    PktbsUser? createdBy,
    PktbsUser? updatedBy,
    PktbsVendor? createdFrom,
  }) {
    return PktbsInventory(
      id: id ?? this.id,
      unit: unit ?? this.unit,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      advance: advance ?? this.advance,
      quantity: quantity ?? this.quantity,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      description: description ?? this.description,
      createdFrom: createdFrom ?? this.createdFrom,
    );
  }

  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.unit: unit,
        _Json.title: title,
        _Json.amount: amount,
        _Json.advance: advance,
        _Json.quantity: quantity,
        _Json.description: description,
        _Json.createdBy: createdBy.toJson(),
        _Json.updatedBy: updatedBy?.toJson(),
        _Json.createdFrom: createdFrom.toJson(),
        _Json.created: created.toUtc().toIso8601String(),
        _Json.updated: updated?.toUtc().toIso8601String(),
      };
  
  String toRawJson() => json.encode(toJson());

  String get createdDate =>
      appSettings.getDateTimeFormat.format(created.toLocal());

  String? get updatedDate => updated != null
      ? appSettings.getDateTimeFormat.format(updated!.toLocal())
      : null;
}
