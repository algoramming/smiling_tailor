import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../inventory/model/inventory.dart';
import '../../inventory/provider/inventory.provider.dart';
import '../../transaction/model/transaction.dart';
import '../../transaction/provider/all.trxs.provider.dart';
import '../model/vendor.dart';

typedef VendorTrxsNotifier = AutoDisposeAsyncNotifierProviderFamily<
    VendorTrxsProvider, List<PktbsTrx>, PktbsVendor>;

final vendorTrxsProvider = VendorTrxsNotifier(VendorTrxsProvider.new);

class VendorTrxsProvider
    extends AutoDisposeFamilyAsyncNotifier<List<PktbsTrx>, PktbsVendor> {
  TextEditingController searchCntrlr = TextEditingController();
  late List<PktbsTrx> _trxs;
  List<PktbsInventory> _inventories = [];
  @override
  FutureOr<List<PktbsTrx>> build(PktbsVendor arg) async {
    _trxs = [];
    _listener();
    ref.watch(allTrxsProvider.select(
        (v) => v.value?.where((e) => e.fromId == arg.id || e.toId == arg.id)));
    _trxs = (await ref.watch(allTrxsProvider.future))
        .where((trx) =>
            trx.isActive && (trx.fromId == arg.id || trx.toId == arg.id))
        .toList();
    ref.watch(inventoryProvider);
    _inventories = (await ref.watch(inventoryProvider.future))
        .where((e) => e.from == arg)
        .toList();
    return _trxs;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  List<PktbsTrx> get rawTrxs => _trxs;

  List<PktbsInventory> get inventories => _inventories;

  List<PktbsTrx> get trxList {
    _trxs.sort((a, b) => b.created.toLocal().compareTo(a.created.toLocal()));
    final vs = _trxs;
    return vs
        .where((e) =>
            e.id.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.fromId.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.toId.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.creator.id
                .toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ||
            (e.updator?.id
                    .toLowerCase()
                    .contains(searchCntrlr.text.toLowerCase()) ??
                false) ||
            (e.description
                    ?.toLowerCase()
                    .contains(searchCntrlr.text.toLowerCase()) ??
                false))
        .toList();
  }
}
