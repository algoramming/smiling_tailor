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
  bool  _showPrevMonth = false;
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

  List<PktbsTrx> get rawTrxs => _trxs;

  List<PktbsTrx> get trxList {
    _trxs.sort((a, b) => b.created.compareTo(a.created));
    final vs = _trxs;
    return vs
        .where((e) =>
            e.description
                ?.toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ??
            false)
        .toList();
  }

  // List<PlutoColumn> get getColumns => columns;

  // final List<PlutoColumn> columns = <PlutoColumn>[
  //   PlutoColumn(
  //     title: 'Id',
  //     field: 'id',
  //     type: PlutoColumnType.text(),
  //   ),
  //   PlutoColumn(
  //     title: 'Name',
  //     field: 'name',
  //     type: PlutoColumnType.text(),
  //   ),
  //   PlutoColumn(
  //     title: 'Phone',
  //     field: 'phone',
  //     type: PlutoColumnType.text(),
  //   ),
  //   PlutoColumn(
  //     title: 'Salary',
  //     field: 'salary',
  //     type: PlutoColumnType.number(),
  //   ),
  //   PlutoColumn(
  //     title: 'Amount',
  //     field: 'amount',
  //     type: PlutoColumnType.number(),
  //   ),
  //   PlutoColumn(
  //     title: 'Transaction Type',
  //     field: 'type',
  //     type: PlutoColumnType.select(<String>[
  //       'Receiveable',
  //       'Payable',
  //     ]),
  //   ),
  //   PlutoColumn(
  //     title: 'Created',
  //     field: 'created',
  //     type: PlutoColumnType.date(),
  //   ),
  //   PlutoColumn(
  //     title: 'Created By',
  //     field: 'created_by',
  //     type: PlutoColumnType.time(),
  //   ),
  //   PlutoColumn(
  //     title: 'Updated',
  //     field: 'updated',
  //     type: PlutoColumnType.date(),
  //   ),
  //   PlutoColumn(
  //     title: 'Updated By',
  //     field: 'updated_by',
  //     type: PlutoColumnType.time(),
  //   ),
  //   // PlutoColumn(
  //   //   title: 'Total Amount',
  //   //   field: 'amount',
  //   //   type: PlutoColumnType.currency(),
  //   //   footerRenderer: (rendererContext) {
  //   //     return PlutoAggregateColumnFooter(
  //   //       rendererContext: rendererContext,
  //   //       formatAsCurrency: true,
  //   //       type: PlutoAggregateColumnType.sum,
  //   //       format: '#,###',
  //   //       alignment: Alignment.center,
  //   //       titleSpanBuilder: (text) {
  //   //         return [
  //   //           const TextSpan(
  //   //             text: 'Sum',
  //   //             style: TextStyle(color: Colors.red),
  //   //           ),
  //   //           const TextSpan(text: ' : '),
  //   //           TextSpan(text: text),
  //   //         ];
  //   //       },
  //   //     );
  //   //   },
  //   // ),
  // ];

  // List<PlutoRow> get getRows => trxList
  //     .map((e) => PlutoRow(cells: {
  //           'id': PlutoCell(value: e.id),
  //           'name': PlutoCell(value: (e.getGLObject() as PktbsEmployee).name),
  //           'phone': PlutoCell(value: (e.getGLObject() as PktbsEmployee).phone),
  //           'salary':
  //               PlutoCell(value: (e.getGLObject() as PktbsEmployee).salary),
  //           'amount': PlutoCell(value: e.amount),
  //           'type':
  //               PlutoCell(value: e.isReceiveable ? 'Receiveable' : 'Payable'),
  //           'created': PlutoCell(value: e.created),
  //           'created_by': PlutoCell(value: e.createdBy.name),
  //           'updated': PlutoCell(value: e.updated),
  //           'updated_by': PlutoCell(value: e.updatedBy?.name),
  //         }))
  //     .toList();

  // List<PlutoColumnGroup> get getColumnGroups => columnGroups;

  // final List<PlutoColumnGroup> columnGroups = [
  //   PlutoColumnGroup(title: 'Id', fields: ['id'], expandedColumn: true),
  //   PlutoColumnGroup(
  //       title: 'User information', fields: ['name', 'phone', 'salary']),
  //   PlutoColumnGroup(title: 'Transaction', children: [
  //     PlutoColumnGroup(
  //         title: 'Amount', fields: ['amount'], expandedColumn: true),
  //     PlutoColumnGroup(title: 'Type', fields: ['type'], expandedColumn: true),
  //     PlutoColumnGroup(title: 'Create', fields: ['created', 'created_by']),
  //     PlutoColumnGroup(title: 'Update', fields: ['updated', 'updated_by']),
  //   ]),
  // ];
}
