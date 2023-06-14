import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../utils/logger/logger_helper.dart';
import '../../transaction/model/transaction.dart';
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
    _stream();
    _trxs = await pb
        .collection(transactions)
        .getFullList(
          filter: 'from_id = "${arg.id}" || to_id = "${arg.id}"',
          expand: pktbsTrxExpand,
        )
        .then((v) {
      log.i('Orders Trxs: $v');
      return v.map((e) => PktbsTrx.fromJson(e.toJson())).toList();
    });
    return _trxs;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  _stream() {
    // Implement Stream needs pocketbase update to add filter and expand options then the autodispose had to remove
    pb.collection(transactions).subscribe('*', (s) async {
      log.i('Stream $s');
      if (s.record?.getStringValue('from_id') != arg.id &&
          s.record?.getStringValue('to_id') != arg.id) return;
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
