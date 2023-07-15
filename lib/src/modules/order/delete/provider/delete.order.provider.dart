import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../../../../shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../transaction/api/trx.api.dart';
import '../../../transaction/model/transaction.dart';
import '../../../transaction/provider/all.trxs.provider.dart';
import '../../api/delete.order.dart';
import '../../model/order.dart';
import '../view/confirmation.order.delete.dart';

typedef DeleteOrderNotifier = AutoDisposeAsyncNotifierProviderFamily<
    DeleteOrderProvider, void, PktbsOrder>;

final deleteOrderProvider = DeleteOrderNotifier(DeleteOrderProvider.new);

class DeleteOrderProvider
    extends AutoDisposeFamilyAsyncNotifier<void, PktbsOrder> {
  late List<PktbsTrx> _trxs;
  late List<bool> _selectedTrxs;
  @override
  FutureOr<void> build(PktbsOrder arg) async {
    _trxs = (await ref.watch(allTrxsProvider.future))
        .where((trx) =>
            trx.isActive && (trx.fromId == arg.id || trx.toId == arg.id))
        .toList();
    _selectedTrxs = List.generate(_trxs.length, (index) => true);
  }

  List<PktbsTrx> get trxs => _trxs;

  bool isSelected(int i) => _selectedTrxs[i];

  void toggleSelected(int i) {
    _selectedTrxs[i] = !_selectedTrxs[i];
    ref.notifyListeners();
  }

  List<PktbsTrx> get selectedTrxs =>
      _trxs.where((e) => _selectedTrxs[_trxs.indexOf(e)]).toList();

  Future<void> submit(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => ConfirmDeleteOrderPopup(
        () async => await pktbsDeleteOrder(context, arg.id).then(
          (r) async {
            if (r) {
              await _deleteTrxs(context).then((_) {
                EasyLoading.dismiss();
                context.pop();
                context.pop();
                showAwesomeSnackbar(
                  context,
                  'Success',
                  'Order & releated transactions deleted successfully',
                  MessageType.success,
                );
              });
            }
          },
        ),
      ),
    );
  }

  Future<void> _deleteTrxs(BuildContext context) async {
    for (final trx in selectedTrxs) {
      await pktbsDeleteTrx(context, trx);
    }
  }
}
