import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../utils/logger/logger_helper.dart';
import '../../transaction/model/transaction.dart';
import '../model/employee.dart';

typedef EmployeeTrxsNotifier = AutoDisposeAsyncNotifierProviderFamily<
    EmployeeTrxsProvider, List<PktbsTrx>, PktbsEmployee>;

final employeeTrxsProvider = EmployeeTrxsNotifier(EmployeeTrxsProvider.new);

class EmployeeTrxsProvider
    extends AutoDisposeFamilyAsyncNotifier<List<PktbsTrx>, PktbsEmployee> {
  TextEditingController searchCntrlr = TextEditingController();
  late List<PktbsTrx> _trxs;
  bool _showPrevMonth = false;
  @override
  FutureOr<List<PktbsTrx>> build(PktbsEmployee arg) async {
    _trxs = [];
    _listener();
    _stream();
    _trxs = await pb
        .collection(transactions)
        .getFullList(filter: 'gl_id = "${arg.id}"', expand: pktbsTrxExpand)
        .then((v) {
      log.i('Employees Trxs: $v');
      return v.map((e) => PktbsTrx.fromJson(e.toJson())).toList();
    });
    return _trxs;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  bool get showPrevMonth => _showPrevMonth;

  void toggleShowPrevMonth() {
    _showPrevMonth = !_showPrevMonth;
    ref.notifyListeners();
  }

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
