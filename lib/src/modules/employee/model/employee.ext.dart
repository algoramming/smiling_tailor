
part of 'employee.dart';

extension EmployeeExtension on PktbsEmployee {

  // copywith function
  PktbsEmployee copyWith({
    String? name,
    String? email,
    String? phone,
    double? salary,
    String? address,
    String? id,
    DateTime? updated,
    String? description,
    DateTime? created,
    String? collectionId,
    String? collectionName,
  }) {
    return PktbsEmployee(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      salary: salary ?? this.salary,
      address: address ?? this.address,
      id: id ?? this.id,
      updated: updated ?? this.updated,
      description: description ?? this.description,
      created: created ?? this.created,
      collectionId: collectionId ?? this.collectionId,
      collectionName: collectionName ?? this.collectionName,
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.name: name,
        _Json.email: email,
        _Json.phone: phone,
        _Json.salary: salary,
        _Json.address: address,
        _Json.description: description,
        _Json.collectionId: collectionId,
        _Json.collectionName: collectionName,
        _Json.created: created.toIso8601String(),
        _Json.updated: updated?.toIso8601String(),
      };

  // to raw json
  String toRawJson() => json.encode(toJson());

}