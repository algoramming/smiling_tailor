part of 'employee.dart';

extension EmployeeExtension on PktbsEmployee {
  PktbsEmployee copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    double? salary,
    String? address,
    DateTime? created,
    DateTime? updated,
    PktbsUser? creator,
    PktbsUser? updator,
    String? description,
    String? collectionId,
    String? collectionName,
  }) {
    return PktbsEmployee(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      salary: salary ?? this.salary,
      creator: creator ?? this.creator,
      updator: updator ?? this.updator,
      address: address ?? this.address,
      updated: updated ?? this.updated,
      created: created ?? this.created,
      description: description ?? this.description,
      collectionId: collectionId ?? this.collectionId,
      collectionName: collectionName ?? this.collectionName,
    );
  }

  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.name: name,
        _Json.email: email,
        _Json.phone: phone,
        _Json.salary: salary,
        _Json.address: address,
        _Json.description: description,
        _Json.creator: creator.toJson(),
        _Json.updator: updator?.toJson(),
        _Json.collectionId: collectionId,
        _Json.collectionName: collectionName,
        _Json.created: created.toIso8601String(),
        _Json.updated: updated?.toIso8601String(),
      };

  String toRawJson() => json.encode(toJson());

  String get createdDate =>
      appSettings.getDateTimeFormat.format(created.toLocal());

  String? get updatedDate => updated != null
      ? appSettings.getDateTimeFormat.format(updated!.toLocal())
      : null;
}
