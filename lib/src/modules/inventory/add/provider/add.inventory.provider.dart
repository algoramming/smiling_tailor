import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../db/db.dart';
import '../../../settings/model/measurement/measurement.dart';
import '../../../transaction/enum/trx.type.dart';
import '../../../transaction/model/transaction.dart';
import '../../../transaction/provider/all.trxs.provider.dart';
import '../../../vendor/model/vendor.dart';
import '../../../vendor/provider/vendor.provider.dart';
import '../../api/add.inventory.api.dart';
import '../../api/edit.inventory.api.dart';
import '../../model/inventory.dart';

typedef AddInventoryNotifier = AutoDisposeAsyncNotifierProviderFamily<
    AddInventoryProvider, void, PktbsInventory?>;

final addInventoryProvider = AddInventoryNotifier(AddInventoryProvider.new);

class AddInventoryProvider
    extends AutoDisposeFamilyAsyncNotifier<void, PktbsInventory?> {
  final quantityCntrlr = TextEditingController(text: '0');
  final advanceCntrlr = TextEditingController(text: '0.0');
  final amountCntrlr = TextEditingController(text: '0.0');
  final descriptionCntrlr = TextEditingController();
  final titleCntrlr = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Measurement> measurements = [];
  List<PktbsVendor> vendors = [];
  PktbsVendor? from;
  Measurement? unit;

  PktbsTrx? advanceTrx;
  PktbsTrx? inventoryTrx;

  @override
  FutureOr<void> build(PktbsInventory? arg) async {
    if (arg != null) {
      final trxs = await ref.watch(allTrxsProvider.future);
      advanceTrx = trxs.any(
        (trx) =>
            trx.isActive &&
            trx.isSystemGenerated &&
            trx.fromType.isVendor &&
            trx.toId == arg.id &&
            trx.voucher == 'Inventory Advance Amount Transaction',
      )
          ? trxs.firstWhere(
              (trx) =>
                  trx.isActive &&
                  trx.isSystemGenerated &&
                  trx.fromType.isVendor &&
                  trx.toId == arg.id &&
                  !trx.isGoods &&
                  trx.voucher == 'Inventory Advance Amount Transaction',
            )
          : null;
      inventoryTrx = trxs.any(
        (trx) =>
            trx.isActive &&
            trx.isSystemGenerated &&
            trx.fromType.isVendor &&
            trx.toId == arg.id &&
            trx.isGoods &&
            trx.voucher == 'Inventory Entry Transaction',
      )
          ? trxs.firstWhere(
              (trx) =>
                  trx.isActive &&
                  trx.isSystemGenerated &&
                  trx.fromType.isVendor &&
                  trx.toId == arg.id &&
                  trx.voucher == 'Inventory Entry Transaction',
            )
          : null;

      titleCntrlr.text = arg.title;
      descriptionCntrlr.text = arg.description ?? '';
      quantityCntrlr.text = arg.quantity.toString();
      advanceCntrlr.text = advanceTrx?.amount.toString() ?? '0.0';
      amountCntrlr.text = arg.amount.toString();
      from = arg.from;
      unit = arg.unit;
    }
    vendors = ref.watch(vendorProvider).value ?? [];
    measurements = appMeasurements
        .where((e) => e.unitOf == 'Length' && e.name != 'Mile')
        .toList();
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    if (arg == null) {
      await pktbsAddInventory(context, this);
    } else {
      await pktbsUpdateInventory(context, this);
    }
  }

  void setCreatedFrom(PktbsVendor? value) {
    from = value;
    ref.notifyListeners();
  }

  void setUnit(Measurement? value) {
    unit = value;
    ref.notifyListeners();
  }

  void clear() {
    formKey = GlobalKey<FormState>();
    descriptionCntrlr.clear();
    quantityCntrlr.clear();
    advanceCntrlr.clear();
    amountCntrlr.clear();
    titleCntrlr.clear();
    from = null;
    unit = null;
    ref.notifyListeners();
  }
}
