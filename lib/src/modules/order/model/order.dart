import 'dart:convert';

import '../../../db/isar.dart';
import '../../../utils/extensions/extensions.dart';
import '../../authentication/model/user.dart';
import '../../employee/model/employee.dart';
import '../../inventory/model/inventory.dart';
import '../../settings/model/settings.model.dart';
import 'enum.dart';

part 'order.ext.dart';

const pktbsOrderExpand =
    'creator, updator, tailorEmployee, tailorEmployee.creator, tailorEmployee.updator, inventory, inventory.creator, inventory.updator, inventory.from, inventory.from.creator, inventory.from.updator, deliveryEmployee, deliveryEmployee.creator, deliveryEmployee.updator';

class PktbsOrder {
  //
  final String id;
  DateTime created;
  DateTime? updated;
  PktbsUser creator;
  PktbsUser? updator;
  String collectionId;
  String collectionName;
  //
  String customerName;
  String? customerEmail;
  String customerPhone;
  String? customerAddress;
  String? customerNote;
  //
  String? measurement;
  String? plate;
  String? sleeve;
  String? colar;
  String? pocket;
  String? button;
  String? measurementNote;
  int quantity;
  //
  PktbsEmployee tailorEmployee;
  double tailorCharge;
  String? tailorNote;
  //
  PktbsInventory? inventory;
  int? inventoryQuantity;
  String? inventoryUnit;
  double? inventoryPrice;
  String? inventoryNote;
  //
  bool isHomeDeliveryNeeded;
  PktbsEmployee? deliveryEmployee;
  String? deliveryAddress;
  double? deliveryCharge;
  String? deliveryNote;
  //
  PaymentMethod paymentMethod;
  String? paymentNote;
  double advanceAmount;
  //
  DateTime deliveryTime;
  String? description;
  OrderStatus status;

  PktbsOrder({
    required this.id,
    required this.created,
    this.updated,
    required this.creator,
    this.updator,
    required this.collectionId,
    required this.collectionName,
    //
    required this.customerName,
    this.customerEmail,
    required this.customerPhone,
    this.customerAddress,
    this.customerNote,
    //
    this.measurement,
    this.plate,
    this.sleeve,
    this.colar,
    this.pocket,
    this.button,
    this.measurementNote,
    required this.quantity,
    //
    required this.tailorEmployee,
    required this.tailorCharge,
    this.tailorNote,
    //
    this.inventory,
    this.inventoryQuantity,
    this.inventoryUnit,
    this.inventoryPrice,
    this.inventoryNote,
    //
    required this.isHomeDeliveryNeeded,
    this.deliveryEmployee,
    this.deliveryAddress,
    this.deliveryCharge,
    this.deliveryNote,
    //
    required this.paymentMethod,
    required this.paymentNote,
    required this.advanceAmount,
    //
    required this.deliveryTime,
    this.description,
    required this.status,
  });

  factory PktbsOrder.fromJson(Map<String, dynamic> json) {
    return PktbsOrder(
      id: json[_Json.id],
      created: DateTime.parse(json[_Json.created]).toLocal(),
      updated: json[_Json.updated] == null || json[_Json.updated] == ''
          ? null
          : DateTime.parse(json[_Json.updated]).toLocal(),
      creator: PktbsUser.fromJson(json[_Json.expand][_Json.creator]),
      updator: json[_Json.updator] == null || json[_Json.updator] == ''
          ? null
          : PktbsUser.fromJson(json[_Json.expand][_Json.updator]),
      collectionId: json[_Json.collectionId],
      collectionName: json[_Json.collectionName],
      //
      customerName: json[_Json.customerName],
      customerEmail: json[_Json.customerEmail],
      customerPhone: json[_Json.customerPhone],
      customerAddress: json[_Json.customerAddress],
      customerNote: json[_Json.customerNote],
      //
      measurement: json[_Json.measurement],
      plate: json[_Json.plate],
      sleeve: json[_Json.sleeve],
      colar: json[_Json.colar],
      pocket: json[_Json.pocket],
      button: json[_Json.button],
      measurementNote: json[_Json.measurementNote],
      quantity: json[_Json.quantity].toString().toInt ?? 0,
      //
      tailorEmployee:
          PktbsEmployee.fromJson(json[_Json.expand][_Json.tailorEmployee]),
      tailorCharge: json[_Json.tailorCharge].toString().toDouble ?? 0.0,
      tailorNote: json[_Json.tailorNote],
      //
      inventory: json[_Json.inventory] == null || json[_Json.inventory] == ''
          ? null
          : PktbsInventory.fromJson(json[_Json.expand][_Json.inventory]),
      inventoryQuantity: json[_Json.inventoryQuantity].toString().toInt,
      inventoryUnit: json[_Json.inventoryUnit],
      inventoryPrice: json[_Json.inventoryPrice].toString().toDouble,
      inventoryNote: json[_Json.inventoryNote],
      //
      isHomeDeliveryNeeded: json[_Json.isHomeDeliveryNeeded],
      deliveryEmployee: json[_Json.deliveryEmployee] == null ||
              json[_Json.deliveryEmployee] == ''
          ? null
          : PktbsEmployee.fromJson(json[_Json.expand][_Json.deliveryEmployee]),
      deliveryAddress: json[_Json.deliveryAddress],
      deliveryCharge: json[_Json.deliveryCharge].toString().toDouble,
      deliveryNote: json[_Json.deliveryNote],
      //
      paymentMethod: (json[_Json.paymentMethod] as String).toPaymentMethod,
      paymentNote: json[_Json.paymentNote],
      advanceAmount: json[_Json.advanceAmount].toString().toDouble ?? 0.0,
      //
      deliveryTime: DateTime.parse(json[_Json.deliveryTime]).toLocal(),
      description: json[_Json.description],
      status: (json[_Json.status] as String).toOrderStatus,
    );
  }

  factory PktbsOrder.fromRawJson(String str) =>
      PktbsOrder.fromJson(json.decode(str));

  @override
  String toString() =>
      'PktbsOrder(id: $id, created: $created, updated: $updated, creator: $creator, updator: $updator, collectionId: $collectionId, collectionName: $collectionName, customerName: $customerName, customerEmail: $customerEmail, customerPhone: $customerPhone, customerAddress: $customerAddress, customerNote: $customerNote, measurement: $measurement, plate: $plate, sleeve: $sleeve, colar: $colar, pocket: $pocket, button: $button, measurementNote: $measurementNote, quantity: $quantity, tailorEmployee: $tailorEmployee, tailorCharge: $tailorCharge, tailorNote: $tailorNote, inventory: $inventory, inventoryQuantity: $inventoryQuantity, inventoryUnit: $inventoryUnit, inventoryPrice: $inventoryPrice, inventoryNote: $inventoryNote, isHomeDeliveryNeeded: $isHomeDeliveryNeeded, deliveryEmployee: $deliveryEmployee, deliveryAddress: $deliveryAddress, deliveryCharge: $deliveryCharge, deliveryNote: $deliveryNote, paymentMethod: $paymentMethod, paymentNote: $paymentNote, advanceAmount: $advanceAmount, deliveryTime: $deliveryTime, description: $description, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PktbsOrder && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _Json {
  static const id = 'id';
  static const created = 'created';
  static const updated = 'updated';
  static const creator = 'creator';
  static const updator = 'updator';
  static const expand = 'expand';
  static const collectionId = 'collectionId';
  static const collectionName = 'collectionName';
  //
  static const customerName = 'customerName';
  static const customerEmail = 'customerEmail';
  static const customerPhone = 'customerPhone';
  static const customerAddress = 'customerAddress';
  static const customerNote = 'customerNote';
  //
  static const measurement = 'measurement';
  static const plate = 'plate';
  static const sleeve = 'sleeve';
  static const colar = 'colar';
  static const pocket = 'pocket';
  static const button = 'button';
  static const measurementNote = 'measurementNote';
  static const quantity = 'quantity';
  //
  static const tailorEmployee = 'tailorEmployee';
  static const tailorCharge = 'tailorCharge';
  static const tailorNote = 'tailorNote';
  //
  static const inventory = 'inventory';
  static const inventoryQuantity = 'inventoryQuantity';
  static const inventoryUnit = 'inventoryUnit';
  static const inventoryPrice = 'inventoryPrice';
  static const inventoryNote = 'inventoryNote';
  //
  static const isHomeDeliveryNeeded = 'isHomeDeliveryNeeded';
  static const deliveryEmployee = 'deliveryEmployee';
  static const deliveryAddress = 'deliveryAddress';
  static const deliveryCharge = 'deliveryCharge';
  static const deliveryNote = 'deliveryNote';
  //
  static const paymentMethod = 'paymentMethod';
  static const paymentNote = 'paymentNote';
  static const advanceAmount = 'advanceAmount';
  //
  static const deliveryTime = 'deliveryTime';
  static const description = 'description';
  static const status = 'status';
}
