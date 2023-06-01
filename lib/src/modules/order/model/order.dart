import 'dart:convert';

import 'package:smiling_tailor/src/modules/employee/model/employee.dart';
import 'package:smiling_tailor/src/modules/inventory/model/inventory.dart';
import 'package:smiling_tailor/src/modules/order/model/enum.dart';

import '../../../db/isar.dart';
import '../../authentication/model/user.dart';
import '../../settings/model/settings.model.dart';

part 'order.ext.dart';

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
  //
  PktbsEmployee tailorEmployee;
  double employeeCharge;
  String? employeeNote;
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
  double paymentNote;
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
    //
    required this.tailorEmployee,
    required this.employeeCharge,
    this.employeeNote,
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
      created: json[_Json.created].toDateTime(),
      updated: json[_Json.updated].toDateTime(),
      creator: json[_Json.creator].toUser(),
      updator: json[_Json.updator].toUser(),
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
      //
      tailorEmployee: json[_Json.tailorEmployee].toEmployee(),
      employeeCharge: json[_Json.employeeCharge],
      employeeNote: json[_Json.employeeNote],
      //
      inventory: json[_Json.inventory].toInventory(),
      inventoryQuantity: json[_Json.inventoryQuantity],
      inventoryUnit: json[_Json.inventoryUnit],
      inventoryPrice: json[_Json.inventoryPrice],
      inventoryNote: json[_Json.inventoryNote],
      //
      isHomeDeliveryNeeded: json[_Json.isHomeDeliveryNeeded],
      deliveryEmployee: json[_Json.deliveryEmployee].toEmployee(),
      deliveryAddress: json[_Json.deliveryAddress],
      deliveryCharge: json[_Json.deliveryCharge],
      deliveryNote: json[_Json.deliveryNote],
      //
      paymentMethod: json[_Json.paymentMethod].toPaymentMethod(),
      paymentNote: json[_Json.paymentNote],
      advanceAmount: json[_Json.advanceAmount],
      //
      deliveryTime: json[_Json.deliveryTime].toDateTime(),
      description: json[_Json.description],
      status: json[_Json.status].toOrderStatus(),
    );
  }

  factory PktbsOrder.fromRawJson(String str) =>
      PktbsOrder.fromJson(json.decode(str));

  @override
  String toString() =>
      'PktbsOrder(id: $id, created: $created, updated: $updated, creator: $creator, updator: $updator, collectionId: $collectionId, collectionName: $collectionName, customerName: $customerName, customerEmail: $customerEmail, customerPhone: $customerPhone, customerAddress: $customerAddress, customerNote: $customerNote, measurement: $measurement, plate: $plate, sleeve: $sleeve, colar: $colar, pocket: $pocket, button: $button, measurementNote: $measurementNote, tailorEmployee: $tailorEmployee, employeeCharge: $employeeCharge, employeeNote: $employeeNote, inventory: $inventory, inventoryQuantity: $inventoryQuantity, inventoryUnit: $inventoryUnit, inventoryPrice: $inventoryPrice, inventoryNote: $inventoryNote, isHomeDeliveryNeeded: $isHomeDeliveryNeeded, deliveryEmployee: $deliveryEmployee, deliveryAddress: $deliveryAddress, deliveryCharge: $deliveryCharge, deliveryNote: $deliveryNote, paymentMethod: $paymentMethod, paymentNote: $paymentNote, advanceAmount: $advanceAmount, deliveryTime: $deliveryTime, description: $description, status: $status)';

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
  //
  static const tailorEmployee = 'tailorEmployee';
  static const employeeCharge = 'employeeCharge';
  static const employeeNote = 'employeeNote';
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
