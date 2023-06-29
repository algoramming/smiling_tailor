import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../transaction/enum/trx.type.dart';
import '../../../transaction/provider/all.trxs.provider.dart';

import '../../../../db/db.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../employee/model/employee.dart';
import '../../../employee/provider/employee.provider.dart';
import '../../../inventory/model/inventory.dart';
import '../../../inventory/provider/inventory.provider.dart';
import '../../../settings/model/measurement/measurement.dart';
import '../../../transaction/model/transaction.dart';
import '../../api/add.order.api.dart';
import '../../api/edit.order.api.dart';
import '../../enum/order.enum.dart';
import '../../model/order.dart';
import '../../provider/order.provider.dart';

typedef AddOrderNotifier = AutoDisposeAsyncNotifierProviderFamily<
    AddOrderProvider, void, PktbsOrder?>;

final addOrderProvider = AddOrderNotifier(AddOrderProvider.new);

class AddOrderProvider
    extends AutoDisposeFamilyAsyncNotifier<void, PktbsOrder?> {
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

  List<PktbsTrx> _trxs = [];
  List<PktbsTrx> paymentOthersTrxs = [];
  PktbsTrx? advanceTrx;
  PktbsTrx? tailorTrx;
  PktbsTrx? inventoryAllocationTrx;
  PktbsTrx? inventoryPurchaseTrx;
  PktbsTrx? deliveryTrx;

  @override
  FutureOr<void> build(PktbsOrder? arg) async {
    if (arg != null) {
      _trxs = (await ref.watch(allTrxsProvider.future))
          .where((e) => e.fromId == arg.id || e.toId == arg.id)
          .toList();
      //
      advanceTrx = _trxs.any((e) => e.isOrderAdvanceAmount)
          ? _trxs.firstWhere((e) => e.isOrderAdvanceAmount)
          : null;

      paymentOthersTrxs = _trxs
          .where((e) =>
              (e.fromType.isUser || e.toType.isUser) &&
              !e.isGoods &&
              !e.isOrderAdvanceAmount)
          .toList();

      tailorTrx = _trxs.any((e) => e.isOrderTailorCharge && !e.isGoods)
          ? _trxs.firstWhere((e) => e.isOrderTailorCharge && !e.isGoods)
          : null;

      inventoryAllocationTrx = _trxs
              .any((e) => e.isOrderInventoryAllocation && e.isGoods)
          ? _trxs.firstWhere((e) => e.isOrderInventoryAllocation && e.isGoods)
          : null;

      inventoryPurchaseTrx = _trxs
              .any((e) => e.isOrderInventoryPurchase && !e.isGoods)
          ? _trxs.firstWhere((e) => e.isOrderInventoryPurchase && !e.isGoods)
          : null;

      deliveryTrx = _trxs.any((e) => e.isOrderDeliveryCharge && !e.isGoods)
          ? _trxs.firstWhere((e) => e.isOrderDeliveryCharge && !e.isGoods)
          : null;

      //
      if (arg.tailorEmployee != null) {
        allocateTailorNow = true;
      }
      if (arg.deliveryEmployee != null) {
        isHomeDeliveryNeeded = true;
      }
      if (arg.inventory != null) {
        isInventoryNeeded = true;
      }

      //
      customerNameCntrlr.text = arg.customerName;
      customerEmailCntrlr.text = arg.customerEmail ?? '';
      customerPhoneCntrlr.text = arg.customerPhone;
      customerAddressCntrlr.text = arg.customerAddress ?? '';
      customerNoteCntrlr.text = arg.customerNote ?? '';
      //
      measurementCntrlr.text = arg.measurement ?? '';
      plateCntrlr.text = arg.plate ?? '';
      sleeveCntrlr.text = arg.sleeve ?? '';
      colarCntrlr.text = arg.colar ?? '';
      pocketCntrlr.text = arg.pocket ?? '';
      buttonCntrlr.text = arg.button ?? '';
      measurementNoteCntrlr.text = arg.measurementNote ?? '';
      quantityCntrlr.text = arg.quantity.toString();
      //
      tailorEmployee = arg.tailorEmployee;
      tailorChargeCntrlr.text = tailorTrx?.amount.toString() ?? '0.0';
      tailorNoteCntrlr.text = arg.tailorNote ?? '';
      //
      inventory = arg.inventory;
      inventoryQuantityCntrlr.text =
          inventoryAllocationTrx?.amount.toInt().toString() ?? '1';
      inventoryUnit = inventoryAllocationTrx?.unit;
      inventoryPriceCntrlr.text =
          inventoryPurchaseTrx?.amount.toString() ?? '0.0';
      inventoryNoteCntrlr.text = arg.inventoryNote ?? '';
      //
      deliveryEmployee = arg.deliveryEmployee;
      deliveryAddressCntrlr.text = arg.deliveryAddress ?? '';
      deliveryChargeCntrlr.text = deliveryTrx?.amount.toString() ?? '0.0';
      deliveryNoteCntrlr.text = arg.deliveryNote ?? '';
      //
      paymentMethod = arg.paymentMethod;
      paymentNoteCntrlr.text = arg.paymentNote ?? '';
      advanceAmountCntrlr.text = advanceTrx?.amount.toString() ?? '0.0';
      //
      deliveryTime = arg.deliveryTime;
      descriptionCntrlr.text = arg.description ?? '';
      status = arg.status;
    }
    employees = ref.watch(employeeProvider).value ?? [];
    inventories = ref.watch(inventoryProvider).value ?? [];
    measurements = appMeasurements
        .where((e) => e.unitOf == 'Length' && e.name != 'Mile')
        .toList();
    orders = (await ref.watch(orderProvider.future));
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

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    if (arg == null) {
      await pktbsAddOrder(context, this);
    } else {
      await pktbsUpdateOrder(context, this);
    }
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
