import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/inventory/provider/inventory.provider.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../utils/logger/logger_helper.dart';
import '../../inventory/model/inventory.dart';
import '../../transaction/model/transaction.dart';
import '../model/vendor.dart';

typedef VendorTrxsNotifier = AutoDisposeAsyncNotifierProviderFamily<
    VendorTrxsProvider, List<PktbsTrx>, PktbsVendor>;

final vendorTrxsProvider = VendorTrxsNotifier(VendorTrxsProvider.new);

class VendorTrxsProvider
    extends AutoDisposeFamilyAsyncNotifier<List<PktbsTrx>, PktbsVendor> {
  TextEditingController searchCntrlr = TextEditingController();
  late List<PktbsTrx> _trxs;
  late List<PktbsInventory> _inventories;
  double _totalPurchase = 0.0;
  @override
  FutureOr<List<PktbsTrx>> build(PktbsVendor arg) async {
    _trxs = [];
    _listener();
    _stream();
    _trxs = await pb
        .collection(transactions)
        .getFullList(filter: 'gl_id = "${arg.id}"', expand: pktbsTrxExpand)
        .then((v) {
      log.i('Vendors Trxs: $v');
      return v.map((e) => PktbsTrx.fromJson(e.toJson())).toList();
    });
    _totalPurchase = (ref.watch(inventoryProvider).value ?? [])
        .where((e) => e.from == arg)
        .fold(0.0, (p, e) => p + e.amount);
    return _trxs;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  _stream() {
    // Implement Stream needs pocketbase update to add filter and expand options then the autodispose had to remove
    pb.collection(transactions).subscribe('*', (s) async {
      log.i('Stream $s');
      if (s.record?.getStringValue('gl_id') != arg.id) return;
      await pb
          .collection(transactions)
          .getOne(s.record!.toJson()['id'], expand: pktbsTrxExpand)
          .then((trx) {
        log.i('Stream After Get Trx: $trx');
        if (s.action == 'create') {
          _trxs.add(PktbsTrx.fromJson(trx.toJson()));
        } else if (s.action == 'update') {
          _trxs.removeWhere((e) => e.id == trx.id);
          _trxs.add(PktbsTrx.fromJson(trx.toJson()));
        } else if (s.action == 'delete') {
          _trxs.removeWhere((e) => e.id == trx.id);
        }
        ref.notifyListeners();
      });
    });
  }

  List<PktbsTrx> get rawTrxs => _trxs;

  double get totalPurchase => _totalPurchase;

  List<PktbsTrx> get trxList {
    _trxs.sort((a, b) => b.created.toLocal().compareTo(a.created.toLocal()));
    final vs = _trxs;
    return vs
        .where((e) =>
            e.description
                ?.toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ??
            false)
        .toList();
  }
}
