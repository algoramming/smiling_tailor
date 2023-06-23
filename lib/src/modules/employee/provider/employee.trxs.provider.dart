import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../transaction/model/transaction.dart';
import '../../transaction/provider/all.trxs.provider.dart';
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
    ref.watch(allTrxsProvider
    // .select((v) => v.value?.any((e) => e.fromId == arg.id || e.toId == arg.id)) // TODO: Issue
    );
    _trxs = (await ref.watch(allTrxsProvider.future))
        .where((trx) => trx.isActive && (trx.fromId == arg.id || trx.toId == arg.id))
        .toList();
    return _trxs;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  bool get showPrevMonth => _showPrevMonth;

  void toggleShowPrevMonth() {
    _showPrevMonth = !_showPrevMonth;
    ref.notifyListeners();
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
