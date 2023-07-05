part of 'order.dart';

extension OrderExtension on PktbsOrder {
  PktbsOrder copyWith({
    String? id,
    double? vat,
    String? plate,
    int? quantity,
    String? colar,
    String? button,
    String? pocket,
    String? sleeve,
    double? amount,
    double? discount,
    DateTime? created,
    DateTime? updated,
    PktbsUser? creator,
    PktbsUser? updator,
    String? tailorNote,
    String? measurement,
    String? paymentNote,
    String? description,
    OrderStatus? status,
    String? deliveryNote,
    String? customerNote,
    String? customerName,
    String? collectionId,
    String? customerEmail,
    String? customerPhone,
    String? inventoryNote,
    DateTime? deliveryTime,
    int? inventoryQuantity,
    String? collectionName,
    String? customerAddress,
    String? measurementNote,
    String? deliveryAddress,
    PktbsInventory? inventory,
    Measurement? inventoryUnit,
    PaymentMethod? paymentMethod,
    PktbsEmployee? tailorEmployee,
    PktbsEmployee? deliveryEmployee,
  }) =>
      PktbsOrder(
        id: id ?? this.id,
        vat: vat ?? this.vat,
        plate: plate ?? this.plate,
        colar: colar ?? this.colar,
        button: button ?? this.button,
        pocket: pocket ?? this.pocket,
        sleeve: sleeve ?? this.sleeve,
        amount: amount ?? this.amount,
        status: status ?? this.status,
        created: created ?? this.created,
        updated: updated ?? this.updated,
        creator: creator ?? this.creator,
        updator: updator ?? this.updator,
        quantity: quantity ?? this.quantity,
        discount: discount ?? this.discount,
        inventory: inventory ?? this.inventory,
        tailorNote: tailorNote ?? this.tailorNote,
        measurement: measurement ?? this.measurement,
        paymentNote: paymentNote ?? this.paymentNote,
        description: description ?? this.description,
        deliveryNote: deliveryNote ?? this.deliveryNote,
        customerNote: customerNote ?? this.customerNote,
        customerName: customerName ?? this.customerName,
        collectionId: collectionId ?? this.collectionId,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        customerEmail: customerEmail ?? this.customerEmail,
        customerPhone: customerPhone ?? this.customerPhone,
        inventoryNote: inventoryNote ?? this.inventoryNote,
        // inventoryUnit: inventoryUnit ?? this.inventoryUnit,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        collectionName: collectionName ?? this.collectionName,
        tailorEmployee: tailorEmployee ?? this.tailorEmployee,
        customerAddress: customerAddress ?? this.customerAddress,
        measurementNote: measurementNote ?? this.measurementNote,
        deliveryAddress: deliveryAddress ?? this.deliveryAddress,
        deliveryEmployee: deliveryEmployee ?? this.deliveryEmployee,
        // inventoryQuantity: inventoryQuantity ?? this.inventoryQuantity,
      );

  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.vat: vat,
        _Json.plate: plate,
        _Json.colar: colar,
        _Json.sleeve: sleeve,
        _Json.pocket: pocket,
        _Json.button: button,
        _Json.amount: amount,
        _Json.discount: discount,
        _Json.quantity: quantity,
        _Json.creator: creator.id,
        _Json.updator: updator?.id,
        _Json.status: status.label,
        _Json.tailorNote: tailorNote,
        _Json.inventory: inventory?.id,
        _Json.measurement: measurement,
        _Json.paymentNote: paymentNote,
        _Json.description: description,
        _Json.customerNote: customerNote,
        _Json.customerName: customerName,
        _Json.collectionId: collectionId,
        _Json.deliveryNote: deliveryNote,
        _Json.inventoryNote: inventoryNote,
        _Json.customerEmail: customerEmail,
        _Json.customerPhone: customerPhone,
        _Json.collectionName: collectionName,
        _Json.measurementNote: measurementNote,
        _Json.customerAddress: customerAddress,
        _Json.deliveryAddress: deliveryAddress,
        _Json.paymentMethod: paymentMethod.label,
        _Json.tailorEmployee: tailorEmployee?.id,
        // _Json.inventoryUnit: inventoryUnit?.name,
        _Json.created: created.toIso8601String(),
        _Json.updated: updated?.toIso8601String(),
        // _Json.inventoryQuantity: inventoryQuantity,
        _Json.deliveryEmployee: deliveryEmployee?.id,
        _Json.deliveryTime: deliveryTime.toIso8601String(),
        _Json.expand: {
          _Json.creator: creator.toJson(),
          if (updator != null) _Json.updator: updator!.toJson(),
          if (inventory != null) _Json.inventory: inventory!.toJson(),
          if (tailorEmployee != null) _Json.tailorEmployee: tailorEmployee!.toJson(),
          if (deliveryEmployee != null) _Json.deliveryEmployee: deliveryEmployee!.toJson(),
        }
      };

  String toRawJson() => json.encode(toJson());

  String get createdDate =>
      appSettings.getDateTimeFormat.format(created.toLocal());

  String? get updatedDate => updated != null
      ? appSettings.getDateTimeFormat.format(updated!.toLocal())
      : null;

  String get deliveryTimeDate =>
      appSettings.getDateTimeFormat.format(deliveryTime.toLocal());

  GLType get glType => GLType.order;

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
