import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:smiling_tailor/src/modules/employee/model/employee.dart';
import 'package:smiling_tailor/src/modules/employee/provider/employee.provider.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../../db/isar.dart';
import '../../../inventory/model/inventory.dart';
import '../../../inventory/provider/inventory.provider.dart';
import '../../../settings/model/measurement/measurement.dart';
import '../../api/add.order.api.dart';
import '../../model/enum.dart';

final lengthMeasurementsProvider = FutureProvider((_) async {
  final ms =
      await db.measurements.where().filter().unitOfEqualTo('Length').findAll();
  ms.removeWhere((element) => element.name == 'Mile');
  return ms;
});

typedef AddOrderNotifier
    = AutoDisposeAsyncNotifierProvider<AddOrderProvider, void>;

final addOrderProvider = AddOrderNotifier(AddOrderProvider.new);

class AddOrderProvider extends AutoDisposeAsyncNotifier<void> {
  final customerNameCntrlr = TextEditingController();
  final customerEmailCntrlr = TextEditingController();
  final customerPhoneCntrlr = TextEditingController();
  final customerAddressCntrlr = TextEditingController();
  final customerNoteCntrlr = TextEditingController();
  //
  final measurementCntrlr = TextEditingController();
  final plateCntrlr = TextEditingController();
  final sleeveCntrlr = TextEditingController();
  final colarCntrlr = TextEditingController();
  final pocketCntrlr = TextEditingController();
  final buttonCntrlr = TextEditingController();
  final measurementNoteCntrlr = TextEditingController();
  final quantityCntrlr = TextEditingController(text: '1');
  //
  PktbsEmployee? tailorEmployee;
  final tailorChargeCntrlr = TextEditingController(text: '0.0');
  final tailorNoteCntrlr = TextEditingController();
  //
  PktbsInventory? inventory;
  final inventoryQuantityCntrlr = TextEditingController(text: '1');
  String? inventoryUnit;
  final inventoryPriceCntrlr = TextEditingController(text: '0.0');
  final inventoryNoteCntrlr = TextEditingController();
  //
  bool isHomeDeliveryNeeded = false;
  PktbsEmployee? deliveryEmployee;
  final deliveryAddressCntrlr = TextEditingController();
  final deliveryChargeCntrlr = TextEditingController(text: '0.0');
  final deliveryNoteCntrlr = TextEditingController();
  //
  PaymentMethod paymentMethod = PaymentMethod.cash;
  final paymentNoteCntrlr = TextEditingController();
  final advanceCntrlr = TextEditingController(text: '0.0');
  //
  DateTime deliveryTime = DateTime.now().addDays(7);
  final descriptionCntrlr = TextEditingController();
  OrderStatus status = OrderStatus.pending;
  //
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<PktbsEmployee> employees = [];
  List<PktbsInventory> inventories = [];
  List<Measurement> measurements = [];

  @override
  FutureOr<void> build() {
    employees = ref.watch(employeeProvider).value ?? [];
    inventories = ref.watch(inventoryProvider).value ?? [];
    measurements = ref.watch(lengthMeasurementsProvider).value ?? [];
  }

  void setTailorEmployee(PktbsEmployee? employee) {
    tailorEmployee = employee;
    ref.notifyListeners();
  }

  void setInventory(PktbsInventory? inventory) {
    this.inventory = inventory;
    ref.notifyListeners();
  }

  void setInventoryUnit(String? unit) {
    inventoryUnit = unit;
    ref.notifyListeners();
  }

  void toggleHomeDelivery() {
    isHomeDeliveryNeeded = !isHomeDeliveryNeeded;
    ref.notifyListeners();
  }

  void setDeliveryEmployee(PktbsEmployee? employee) {
    deliveryEmployee = employee;
    ref.notifyListeners();
  }

  void setPaymentMethod(PaymentMethod method) {
    paymentMethod = method;
    ref.notifyListeners();
  }

  void setDeliveryTime(DateTime time) {
    deliveryTime = time;
    ref.notifyListeners();
  }

  void setStatus(OrderStatus status) {
    this.status = status;
    ref.notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    await pktbsAddOrder(context, this);
  }

  void clear() {
    formKey = GlobalKey<FormState>();
    customerNameCntrlr.clear();
    customerEmailCntrlr.clear();
    customerPhoneCntrlr.clear();
    customerAddressCntrlr.clear();
    customerNoteCntrlr.clear();
    //
    measurementCntrlr.clear();
    plateCntrlr.clear();
    sleeveCntrlr.clear();
    colarCntrlr.clear();
    pocketCntrlr.clear();
    buttonCntrlr.clear();
    measurementNoteCntrlr.clear();
    quantityCntrlr.text = '1';
    //
    tailorEmployee = null;
    tailorChargeCntrlr.text = '0.0';
    tailorNoteCntrlr.clear();
    //
    inventory = null;
    inventoryQuantityCntrlr.text = '1';
    inventoryUnit = null;
    inventoryPriceCntrlr.text = '0.0';
    inventoryNoteCntrlr.clear();
    //
    isHomeDeliveryNeeded = false;
    deliveryEmployee = null;
    deliveryAddressCntrlr.clear();
    deliveryChargeCntrlr.text = '0.0';
    deliveryNoteCntrlr.clear();
    //
    paymentMethod = PaymentMethod.cash;
    paymentNoteCntrlr.clear();
    advanceCntrlr.text = '0.0';
    //
    deliveryTime = DateTime.now().addDays(7);
    descriptionCntrlr.clear();
    status = OrderStatus.pending;
    //
    ref.notifyListeners();
  }
}
