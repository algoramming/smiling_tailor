
part of 'vendor.dart';

extension VendorExtension on PktbsVendor {

  // copywith function
  PktbsVendor copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    DateTime? created,
    DateTime? updated,
    String? description,
    String? collectionId,
    double? openingBalance,
    String? collectionName,
  }) {
    return PktbsVendor(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      description: description ?? this.description,
      collectionId: collectionId ?? this.collectionId,
      openingBalance: openingBalance ?? this.openingBalance,
      collectionName: collectionName ?? this.collectionName,
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.name: name,
        _Json.email: email,
        _Json.phone: phone,
        _Json.address: address,
        _Json.description: description,
        _Json.collectionId: collectionId,
        _Json.openingBalance: openingBalance,
        _Json.collectionName: collectionName,
        _Json.created: created.toIso8601String(),
        _Json.updated: updated?.toIso8601String(),
      };

  // to raw json
  String toRawJson() => json.encode(toJson());
}