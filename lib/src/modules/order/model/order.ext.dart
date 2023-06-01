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
    //
    PktbsEmployee? tailorEmployee,
    double? employeeCharge,
    String? employeeNote,
    //
    PktbsInventory? inventory,
    int? inventoryQuantity,
    String? inventoryUnit,
    double? inventoryPrice,
    String? inventoryNote,
    //
    bool? isHomeDeliveryNeeded,
    PktbsEmployee? deliveryEmployee,
    String? deliveryAddress,
    double? deliveryCharge,
    String? deliveryNote,
    //
    PaymentMethod? paymentMethod,
    double? paymentNote,
    double? advanceAmount,
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
        //
        tailorEmployee: tailorEmployee ?? this.tailorEmployee,
        employeeCharge: employeeCharge ?? this.employeeCharge,
        employeeNote: employeeNote ?? this.employeeNote,
        //
        inventory: inventory ?? this.inventory,
        inventoryQuantity: inventoryQuantity ?? this.inventoryQuantity,
        inventoryUnit: inventoryUnit ?? this.inventoryUnit,
        inventoryPrice: inventoryPrice ?? this.inventoryPrice,
        inventoryNote: inventoryNote ?? this.inventoryNote,
        //
        isHomeDeliveryNeeded: isHomeDeliveryNeeded ?? this.isHomeDeliveryNeeded,
        deliveryEmployee: deliveryEmployee ?? this.deliveryEmployee,
        deliveryAddress: deliveryAddress ?? this.deliveryAddress,
        deliveryCharge: deliveryCharge ?? this.deliveryCharge,
        deliveryNote: deliveryNote ?? this.deliveryNote,
        //
        paymentMethod: paymentMethod ?? this.paymentMethod,
        paymentNote: paymentNote ?? this.paymentNote,
        advanceAmount: advanceAmount ?? this.advanceAmount,
        //
        deliveryTime: deliveryTime ?? this.deliveryTime,
        description: description ?? this.description,
        status: status ?? this.status,
      );

  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.created: created.toIso8601String(),
        _Json.updated: updated?.toIso8601String(),
        _Json.creator: creator.toJson(),
        _Json.updator: updator?.toJson(),
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
        //
        _Json.tailorEmployee: tailorEmployee.toJson(),
        _Json.employeeCharge: employeeCharge,
        _Json.employeeNote: employeeNote,
        //
        _Json.inventory: inventory?.toJson(),
        _Json.inventoryQuantity: inventoryQuantity,
        _Json.inventoryUnit: inventoryUnit,
        _Json.inventoryPrice: inventoryPrice,
        _Json.inventoryNote: inventoryNote,
        //
        _Json.isHomeDeliveryNeeded: isHomeDeliveryNeeded,
        _Json.deliveryEmployee: deliveryEmployee?.toJson(),
        _Json.deliveryAddress: deliveryAddress,
        _Json.deliveryCharge: deliveryCharge,
        _Json.deliveryNote: deliveryNote,
        //
        _Json.paymentMethod: paymentMethod.label,
        _Json.paymentNote: paymentNote,
        _Json.advanceAmount: advanceAmount,
        //
        _Json.deliveryTime: deliveryTime.toIso8601String(),
        _Json.description: description,
        _Json.status: status.label,
      };

  String toRawJson() => json.encode(toJson());

  String get createdDate =>
      appSettings.getDateTimeFormat.format(created.toLocal());

  String? get updatedDate => updated != null
      ? appSettings.getDateTimeFormat.format(updated!.toLocal())
      : null;

  String get deliveryTimeDate =>
      appSettings.getDateTimeFormat.format(deliveryTime.toLocal());
}
