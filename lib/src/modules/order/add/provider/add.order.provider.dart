import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../db/isar.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../employee/model/employee.dart';
import '../../../employee/provider/employee.provider.dart';
import '../../../inventory/model/inventory.dart';
import '../../../inventory/provider/inventory.provider.dart';
import '../../../settings/model/measurement/measurement.dart';
import '../../api/add.order.api.dart';
import '../../enum/order.enum.dart';
import '../../model/order.dart';
import '../../provider/order.provider.dart';

// final lengthMeasurementsProvider = FutureProvider((_) async {
//   final ms =
//       await db.measurements.where().filter().unitOfEqualTo('Length').findAll();
//   ms.removeWhere((element) => element.name == 'Mile');
//   return ms;
// });

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
  Measurement? inventoryUnit;
  final inventoryPriceCntrlr = TextEditingController(text: '0.0');
  final inventoryNoteCntrlr = TextEditingController();
  //
  PktbsEmployee? deliveryEmployee;
  final deliveryAddressCntrlr = TextEditingController();
  final deliveryChargeCntrlr = TextEditingController(text: '0.0');
  final deliveryNoteCntrlr = TextEditingController();
  //
  PaymentMethod paymentMethod = PaymentMethod.cash;
  final paymentNoteCntrlr = TextEditingController();
  final advanceAmountCntrlr = TextEditingController(text: '0.0');
  //
  DateTime deliveryTime = DateTime.now().addDays(7);
  final descriptionCntrlr = TextEditingController();
  OrderStatus status = OrderStatus.pending;
  //
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<PktbsEmployee> employees = [];
  List<PktbsInventory> inventories = [];
  List<Measurement> measurements = [];
  List<PktbsOrder> orders = [];
  //
  bool allocateTailorNow = false;
  bool isHomeDeliveryNeeded = false;
  bool isInventoryNeeded = false;

  @override
  FutureOr<void> build() {
    employees = ref.watch(employeeProvider).value ?? [];
    inventories = ref.watch(inventoryProvider).value ?? [];
    measurements = appMeasurements
        .where((e) => e.unitOf == 'Length' && e.name != 'Mile')
        .toList();
    orders = ref.watch(orderProvider).value ?? [];
  }

  void setTailorEmployee(PktbsEmployee? employee) {
    tailorEmployee = employee;
    ref.notifyListeners();
  }

  void setInventory(PktbsInventory? inventory) {
    this.inventory = inventory;
    inventoryUnit = inventory?.unit;
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

  void setOrderStatus(OrderStatus status) {
    this.status = status;
    ref.notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    await pktbsAddOrder(context, this);
  }

  void reload() => ref.notifyListeners();

  void toggleAllocateTailorNow(bool v) {
    allocateTailorNow = v;
    if (v == false) {
      tailorEmployee = null;
      tailorChargeCntrlr.text = '0.0';
      tailorNoteCntrlr.clear();
    }
    ref.notifyListeners();
  }

  void toggleHomeDeliveryNeeded(bool v) {
    isHomeDeliveryNeeded = v;
    if (v == false) {
      deliveryEmployee = null;
      deliveryAddressCntrlr.clear();
      deliveryChargeCntrlr.text = '0.0';
      deliveryNoteCntrlr.clear();
    }
    ref.notifyListeners();
  }

  void toggleInventoryNeeded(bool v) {
    isInventoryNeeded = v;
    if (v == false) {
      inventory = null;
      inventoryQuantityCntrlr.text = '1';
      inventoryUnit = null;
      inventoryPriceCntrlr.text = '0.0';
      inventoryNoteCntrlr.clear();
    }
    ref.notifyListeners();
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
    deliveryEmployee = null;
    deliveryAddressCntrlr.clear();
    deliveryChargeCntrlr.text = '0.0';
    deliveryNoteCntrlr.clear();
    //
    paymentMethod = PaymentMethod.cash;
    paymentNoteCntrlr.clear();
    advanceAmountCntrlr.text = '0.0';
    //
    deliveryTime = DateTime.now().addDays(7);
    descriptionCntrlr.clear();
    status = OrderStatus.pending;
    //
    isHomeDeliveryNeeded = false;
    isInventoryNeeded = false;
    //
    ref.notifyListeners();
  }
}
