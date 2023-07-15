import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../transaction/model/transaction.dart';
import '../../transaction/provider/all.trxs.provider.dart';
import '../model/order.dart';

typedef OrderTrxsNotifier = AutoDisposeAsyncNotifierProviderFamily<
    OrderTrxsProvider, List<PktbsTrx>, PktbsOrder>;

final orderTrxsProvider = OrderTrxsNotifier(OrderTrxsProvider.new);

class OrderTrxsProvider
    extends AutoDisposeFamilyAsyncNotifier<List<PktbsTrx>, PktbsOrder> {
  TextEditingController searchCntrlr = TextEditingController();
  late List<PktbsTrx> _trxs;
  @override
  FutureOr<List<PktbsTrx>> build(PktbsOrder arg) async {
    _trxs = [];
    _listener();
    ref.watch(allTrxsProvider.select(
        (v) => v.value?.where((e) => e.fromId == arg.id || e.toId == arg.id)));
    _trxs = (await ref.watch(allTrxsProvider.future))
        .where((trx) =>
            trx.isActive && (trx.fromId == arg.id || trx.toId == arg.id))
        .toList();
    return _trxs;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  List<PktbsTrx> get rawTrxs => _trxs;

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
