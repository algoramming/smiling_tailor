import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../pocketbase/auth.store/helpers.dart';
import '../../../../shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../../../../shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../transaction/api/trx.api.dart';
import '../../../transaction/enum/trx.type.dart';
import '../../../transaction/model/transaction.dart';
import '../../model/order.dart';
import '../../model/order.trx.dart';

typedef AddTrxOrderNotifier
    = AutoDisposeNotifierProviderFamily<AddTrxOrderProvider, void, OrderTrx>;

final addTrxOrderProvider = AddTrxOrderNotifier(AddTrxOrderProvider.new);

class AddTrxOrderProvider extends AutoDisposeFamilyNotifier<void, OrderTrx> {
  final amountCntrlr = TextEditingController(text: '0.0');
  final descriptionCntrlr = TextEditingController();
  bool isPaybale = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void build(OrderTrx arg) {
    if (arg.trx != null) {
      amountCntrlr.text = arg.trx!.amount.toString();
      descriptionCntrlr.text = arg.trx!.description ?? '';
      isPaybale = arg.trx!.trxType == TrxType.credit;
    }
  }

  PktbsOrder get order => arg.order;

  void toggleIsPayable() {
    isPaybale = !isPaybale;
    ref.notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    if (arg.trx == null) {
      await pktbsAddTrx(
        context,
        fromId: order.id,
        fromJson: order.toJson(),
        fromType: order.glType,
        toId: pb.authStore.model?.id,
        toJson: pb.authStore.model?.toJson(),
        toType: GLType.user,
        amount: double.parse(amountCntrlr.text),
        trxType: isPaybale ? TrxType.debit : TrxType.credit,
        description: descriptionCntrlr.text,
        voucher: 'Order Transaction',
      ).then((r) {
        if (r != null) {
          clear();
          context.pop();
          showAwesomeSnackbar(context, 'Success!',
              'Transaction added successfully.', MessageType.success);
        }
      });
    } else {
      await pktbsUpdateTrx(
        context,
        arg.trx!.copyWith(
          description: descriptionCntrlr.text,
          amount: double.parse(amountCntrlr.text),
          trxType: isPaybale ? TrxType.credit : TrxType.debit,
        ),
      ).then((r) {
        if (r != null) {
          clear();
          context.pop();
          showAwesomeSnackbar(context, 'Success!',
              'Transaction updated successfully.', MessageType.success);
        }
      });
    }
  }

  void clear() {
    formKey = GlobalKey<FormState>();
    amountCntrlr.text = '0.0';
    descriptionCntrlr.clear();
    ref.notifyListeners();
  }
}
