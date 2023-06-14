import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../db/isar.dart';
import '../../../utils/extensions/extensions.dart';
import '../../authentication/model/user.dart';
import '../../employee/model/employee.dart';
import '../../inventory/model/inventory.dart';
import '../../settings/model/measurement/measurement.dart';
import '../../settings/model/settings.model.dart';
import '../../transaction/enum/trx.type.dart';
import '../enum/order.enum.dart';

part 'order.ext.dart';

const pktbsOrderExpand =
    'creator, updator, tailorEmployee, tailorEmployee.creator, tailorEmployee.updator, inventory, inventory.creator, inventory.updator, inventory.from, inventory.from.creator, inventory.from.updator, deliveryEmployee, deliveryEmployee.creator, deliveryEmployee.updator';

const advanceAmountOrderVoucher = 'Order Advance Amount Transaction';
const tailorChargeOrderVoucher = 'Order Tailor Charge Transaction';
const inventoryAllocationOrderVoucher = 'Order Inventory Allocation Transaction';
const inventoryPurchaseOrderVoucher = 'Order Inventory Purchase Transaction';
const deliveryOrderVoucher = 'Order Delivery Charge Transaction';

class PktbsOrder {
  int quantity;
  double amount;
  String? plate;
  String? colar;
  String? sleeve;
  String? pocket;
  String? button;
  final String id;
  DateTime created;
  DateTime? updated;
  PktbsUser creator;
  OrderStatus status;
  String? tailorNote;
  PktbsUser? updator;
  String? description;
  String collectionId;
  String? measurement;
  String customerName;
  String? paymentNote;
  String? deliveryNote;
  String? customerNote;
  String customerPhone;
  DateTime deliveryTime;
  String? customerEmail;
  String collectionName;
  String? inventoryNote;
  int? inventoryQuantity;
  String? customerAddress;
  String? measurementNote;
  String? deliveryAddress;
  PktbsInventory? inventory;
  Measurement? inventoryUnit;
  PaymentMethod paymentMethod;
  PktbsEmployee? tailorEmployee;
  PktbsEmployee? deliveryEmployee;

  PktbsOrder({
    this.plate,
    this.sleeve,
    this.colar,
    this.pocket,
    this.button,
    this.updated,
    this.updator,
    this.inventory,
    this.tailorNote,
    this.paymentNote,
    this.description,
    required this.id,
    this.measurement,
    this.customerNote,
    this.deliveryNote,
    this.customerEmail,
    this.inventoryUnit,
    this.inventoryNote,
    this.tailorEmployee,
    required this.status,
    this.deliveryAddress,
    this.customerAddress,
    this.measurementNote,
    required this.amount,
    required this.created,
    required this.creator,
    this.deliveryEmployee,
    required this.quantity,
    this.inventoryQuantity,
    required this.deliveryTime,
    required this.collectionId,
    required this.customerName,
    required this.paymentMethod,
    required this.customerPhone,
    required this.collectionName,
  });

  factory PktbsOrder.fromJson(Map<String, dynamic> json) {
    return PktbsOrder(
      id: json[_Json.id],
      colar: json[_Json.colar],
      plate: json[_Json.plate],
      sleeve: json[_Json.sleeve],
      pocket: json[_Json.pocket],
      button: json[_Json.button],
      tailorNote: json[_Json.tailorNote],
      description: json[_Json.description],
      paymentNote: json[_Json.paymentNote],
      measurement: json[_Json.measurement],
      deliveryNote: json[_Json.deliveryNote],
      collectionId: json[_Json.collectionId],
      customerName: json[_Json.customerName],
      customerNote: json[_Json.customerNote],
      inventoryNote: json[_Json.inventoryNote],
      customerEmail: json[_Json.customerEmail],
      customerPhone: json[_Json.customerPhone],
      collectionName: json[_Json.collectionName],
      customerAddress: json[_Json.customerAddress],
      measurementNote: json[_Json.measurementNote],
      deliveryAddress: json[_Json.deliveryAddress],
      status: (json[_Json.status] as String).toOrderStatus,
      quantity: json[_Json.quantity].toString().toInt ?? 0,
      amount: json[_Json.amount].toString().toDouble ?? 0.0,
      created: DateTime.parse(json[_Json.created]).toLocal(),
      creator: PktbsUser.fromJson(json[_Json.expand][_Json.creator]),
      deliveryTime: DateTime.parse(json[_Json.deliveryTime]).toLocal(),
      inventoryQuantity: json[_Json.inventoryQuantity].toString().toInt,
      updator: json[_Json.updator] == null || json[_Json.updator] == ''
          ? null
          : PktbsUser.fromJson(json[_Json.expand][_Json.updator]),
      paymentMethod: (json[_Json.paymentMethod] as String).toPaymentMethod,
      updated: json[_Json.updated] == null || json[_Json.updated] == ''
          ? null
          : DateTime.parse(json[_Json.updated]).toLocal(),
      tailorEmployee: json[_Json.tailorEmployee] == null ||
              json[_Json.tailorEmployee] == ''
          ? null
          : PktbsEmployee.fromJson(json[_Json.expand][_Json.tailorEmployee]),
      inventoryUnit: (json[_Json.inventoryUnit] as String?)?.getMeasurement,
      inventory: json[_Json.inventory] == null || json[_Json.inventory] == ''
          ? null
          : PktbsInventory.fromJson(json[_Json.expand][_Json.inventory]),
      deliveryEmployee: json[_Json.deliveryEmployee] == null ||
              json[_Json.deliveryEmployee] == ''
          ? null
          : PktbsEmployee.fromJson(json[_Json.expand][_Json.deliveryEmployee]),
    );
  }

  factory PktbsOrder.fromRawJson(String str) =>
      PktbsOrder.fromJson(json.decode(str));

  @override
  String toString() =>
      'PktbsOrder(id: $id, created: $created, updated: $updated, creator: $creator, updator: $updator, collectionId: $collectionId, collectionName: $collectionName, customerName: $customerName, customerEmail: $customerEmail, customerPhone: $customerPhone, customerAddress: $customerAddress, customerNote: $customerNote, measurement: $measurement, plate: $plate, sleeve: $sleeve, colar: $colar, pocket: $pocket, button: $button, measurementNote: $measurementNote, quantity: $quantity, tailorEmployee: $tailorEmployee, tailorNote: $tailorNote, inventory: $inventory, inventoryQuantity: $inventoryQuantity, inventoryUnit: $inventoryUnit, inventoryNote: $inventoryNote, deliveryEmployee: $deliveryEmployee, deliveryAddress: $deliveryAddress, deliveryNote: $deliveryNote, paymentMethod: $paymentMethod, paymentNote: $paymentNote, amount: $amount, deliveryTime: $deliveryTime, description: $description, status: $status)';

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
  static const colar = 'colar';
  static const plate = 'plate';
  static const status = 'status';
  static const expand = 'expand';
  static const sleeve = 'sleeve';
  static const pocket = 'pocket';
  static const button = 'button';
  static const amount = 'amount';
  static const created = 'created';
  static const updated = 'updated';
  static const creator = 'creator';
  static const updator = 'updator';
  static const quantity = 'quantity';
  static const inventory = 'inventory';
  static const tailorNote = 'tailorNote';
  static const paymentNote = 'paymentNote';
  static const measurement = 'measurement';
  static const description = 'description';
  static const deliveryNote = 'deliveryNote';
  static const customerName = 'customerName';
  static const collectionId = 'collectionId';
  static const customerNote = 'customerNote';
  static const deliveryTime = 'deliveryTime';
  static const paymentMethod = 'paymentMethod';
  static const inventoryUnit = 'inventoryUnit';
  static const inventoryNote = 'inventoryNote';
  static const customerEmail = 'customerEmail';
  static const customerPhone = 'customerPhone';
  static const tailorEmployee = 'tailorEmployee';
  static const collectionName = 'collectionName';
  static const customerAddress = 'customerAddress';
  static const measurementNote = 'measurementNote';
  static const deliveryAddress = 'deliveryAddress';
  static const deliveryEmployee = 'deliveryEmployee';
  static const inventoryQuantity = 'inventoryQuantity';
}
