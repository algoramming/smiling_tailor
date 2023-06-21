import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../utils/logger/logger_helper.dart';
import '../../transaction/model/transaction.dart';

typedef AllTrxsNotifier
    = AsyncNotifierProvider<AllTrxsProvider, List<PktbsTrx>>;

final allTrxsProvider = AllTrxsNotifier(AllTrxsProvider.new);

class AllTrxsProvider extends AsyncNotifier<List<PktbsTrx>> {
  late List<PktbsTrx> _trxs;
  @override
  FutureOr<List<PktbsTrx>> build() async {
    _trxs = [];
    _stream();
    _trxs = await pb
        .collection(transactions)
        .getFullList(expand: pktbsTrxExpand)
        .then((v) {
      log.i('All Trxs: $v');
      return v.map((e) => PktbsTrx.fromJson(e.toJson())).toList();
    });
    return _trxs;
  }

  _stream() {
    // Implement Stream needs pocketbase update to add filter and expand options then the autodispose had to remove
    pb.collection(transactions).subscribe('*', (s) async {
      log.i('Stream $s');
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
    return vs;
  }
}
