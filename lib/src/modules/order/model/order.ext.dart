part of 'order.dart';

extension OrderExtension on PktbsOrder {
  PktbsOrder copyWith({
    String? id,
    DateTime? created,
    DateTime? updated,
    PktbsUser? creator,
    PktbsUser? updator,
    String? collectionId,
    String? collectionName,
    //
    String? customerName,
    String? customerEmail,
    String? customerPhone,
    String? customerAddress,
    String? customerNote,
    //
    String? measurement,
    String? plate,
    String? sleeve,
    String? colar,
    String? pocket,
    String? button,
    String? measurementNote,
    int? quantity,
    //
    PktbsEmployee? tailorEmployee,
    // double? tailorCharge,
    String? tailorNote,
    //
    PktbsInventory? inventory,
    int? inventoryQuantity,
    Measurement? inventoryUnit,
    // double? inventoryPrice,
    String? inventoryNote,
    //
    PktbsEmployee? deliveryEmployee,
    String? deliveryAddress,
    // double? deliveryCharge,
    String? deliveryNote,
    //
    PaymentMethod? paymentMethod,
    String? paymentNote,
    double? amount,
    //
    DateTime? deliveryTime,
    String? description,
    OrderStatus? status,
  }) =>
      PktbsOrder(
        id: id ?? this.id,
        created: created ?? this.created,
        updated: updated ?? this.updated,
        creator: creator ?? this.creator,
        updator: updator ?? this.updator,
        collectionId: collectionId ?? this.collectionId,
        collectionName: collectionName ?? this.collectionName,
        //
        customerName: customerName ?? this.customerName,
        customerEmail: customerEmail ?? this.customerEmail,
        customerPhone: customerPhone ?? this.customerPhone,
        customerAddress: customerAddress ?? this.customerAddress,
        customerNote: customerNote ?? this.customerNote,
        //
        measurement: measurement ?? this.measurement,
        plate: plate ?? this.plate,
        sleeve: sleeve ?? this.sleeve,
        colar: colar ?? this.colar,
        pocket: pocket ?? this.pocket,
        button: button ?? this.button,
        measurementNote: measurementNote ?? this.measurementNote,
        quantity: quantity ?? this.quantity,
        //
        tailorEmployee: tailorEmployee ?? this.tailorEmployee,
        // tailorCharge: tailorCharge ?? this.tailorCharge,
        tailorNote: tailorNote ?? this.tailorNote,
        //
        inventory: inventory ?? this.inventory,
        inventoryQuantity: inventoryQuantity ?? this.inventoryQuantity,
        inventoryUnit: inventoryUnit ?? this.inventoryUnit,
        // inventoryPrice: inventoryPrice ?? this.inventoryPrice,
        inventoryNote: inventoryNote ?? this.inventoryNote,
        //
        deliveryEmployee: deliveryEmployee ?? this.deliveryEmployee,
        deliveryAddress: deliveryAddress ?? this.deliveryAddress,
        // deliveryCharge: deliveryCharge ?? this.deliveryCharge,
        deliveryNote: deliveryNote ?? this.deliveryNote,
        //
        paymentMethod: paymentMethod ?? this.paymentMethod,
        paymentNote: paymentNote ?? this.paymentNote,
        amount: amount ?? this.amount,
        //
        deliveryTime: deliveryTime ?? this.deliveryTime,
        description: description ?? this.description,
        status: status ?? this.status,
      );

  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.created: created.toIso8601String(),
        _Json.updated: updated?.toIso8601String(),
        _Json.creator: creator.id,
        _Json.updator: updator?.id,
        _Json.collectionId: collectionId,
        _Json.collectionName: collectionName,
        //
        _Json.customerName: customerName,
        _Json.customerEmail: customerEmail,
        _Json.customerPhone: customerPhone,
        _Json.customerAddress: customerAddress,
        _Json.customerNote: customerNote,
        //
        _Json.measurement: measurement,
        _Json.plate: plate,
        _Json.sleeve: sleeve,
        _Json.colar: colar,
        _Json.pocket: pocket,
        _Json.button: button,
        _Json.measurementNote: measurementNote,
        _Json.quantity: quantity,
        //
        _Json.tailorEmployee: tailorEmployee?.id,
        // _Json.tailorCharge: tailorCharge,
        _Json.tailorNote: tailorNote,
        //
        _Json.inventory: inventory?.id,
        _Json.inventoryQuantity: inventoryQuantity,
        _Json.inventoryUnit: inventoryUnit?.name,
        // _Json.inventoryPrice: inventoryPrice,
        _Json.inventoryNote: inventoryNote,
        //
        _Json.deliveryEmployee: deliveryEmployee?.id,
        _Json.deliveryAddress: deliveryAddress,
        // _Json.deliveryCharge: deliveryCharge,
        _Json.deliveryNote: deliveryNote,
        //
        _Json.paymentMethod: paymentMethod.label,
        _Json.paymentNote: paymentNote,
        _Json.amount: amount,
        //
        _Json.deliveryTime: deliveryTime.toIso8601String(),
        _Json.description: description,
        _Json.status: status.label,
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
