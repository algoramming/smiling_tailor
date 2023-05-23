import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/employee/model/employee.dart';
import 'package:smiling_tailor/src/modules/transaction/model/transaction.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../utils/logger/logger_helper.dart';

typedef EmployeeTrxsNotifier = AutoDisposeAsyncNotifierProviderFamily<
    EmployeeTrxsProvider, List<PktbsTrx>, PktbsEmployee>;

final employeeTrxsProvider = EmployeeTrxsNotifier(EmployeeTrxsProvider.new);

class EmployeeTrxsProvider
    extends AutoDisposeFamilyAsyncNotifier<List<PktbsTrx>, PktbsEmployee> {
  TextEditingController searchCntrlr = TextEditingController();
  late List<PktbsTrx> _trxs;
  @override
  FutureOr<List<PktbsTrx>> build(PktbsEmployee arg) async {
    _trxs = [];
    _listener();
    _stream();
    _trxs = await pb
        .collection(transactions)
        .getFullList(
            filter: 'gl_id = "${arg.id}"', expand: 'created_by, updated_by')
        .then((v) {
      log.i('Employees Trxs: $v');
      return v.map((e) {
        log.wtf('Employee Trx: $e');
        return PktbsTrx.fromJson(e.toJson());
      }).toList();
    });
    return _trxs;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  _stream() {
    // Implement Stream needs pocketbase update to add filter and expand options then the autodispose had to remove
    pb.collection(transactions).subscribe('*', (s) async {
      log.i('Stream $s');
      if (s.record?.getStringValue('gl_id') != arg.id) return;
      debugPrint(
          'Stream gl_id: ${s.record?.getStringValue('gl_id')} => ${arg.id}');
      debugPrint('Stream action: ${s.action}');
      debugPrint('Stream record: ${s.record!.toJson()['id']}');
      await pb
          .collection(transactions)
          .getOne(s.record!.toJson()['id'], expand: 'created_by, updated_by')
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

  List<PktbsTrx> get trxList {
    _trxs.sort((a, b) => b.created.compareTo(a.created));
    final vs = _trxs;
    return vs
        .where((e) =>
            e.glId.toLowerCase().contains(searchCntrlr.text.toLowerCase()))
        .toList();
  }
}
