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
        _Json.creator: creator.id,
        _Json.updator: updator?.id,
        _Json.collectionId: collectionId,
        _Json.collectionName: collectionName,
        _Json.created: created.toIso8601String(),
        _Json.updated: updated?.toIso8601String(),
        _Json.expand: {
          _Json.creator: creator.toJson(),
          if (updator != null) _Json.updator: updator?.toJson(),
        }
      };

  String toRawJson() => json.encode(toJson());

  String get createdDate =>
      appSettings.getDateTimeFormat.format(created.toLocal());

  String? get updatedDate => updated != null
      ? appSettings.getDateTimeFormat.format(updated!.toLocal())
      : null;

  GLType get glType => GLType.employee;

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
