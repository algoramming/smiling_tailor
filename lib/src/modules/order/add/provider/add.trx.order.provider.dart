import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../pocketbase/auth.store/helpers.dart';
import '../../../../shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../../../../shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../transaction/api/add.trx.api.dart';
import '../../../transaction/enum/trx.type.dart';
import '../../model/order.dart';

typedef AddTrxOrderNotifier
    = AutoDisposeNotifierProviderFamily<AddTrxOrderProvider, void, PktbsOrder>;

final addTrxOrderProvider = AddTrxOrderNotifier(AddTrxOrderProvider.new);

class AddTrxOrderProvider extends AutoDisposeFamilyNotifier<void, PktbsOrder> {
  final amountCntrlr = TextEditingController(text: '0.0');
  final descriptionCntrlr = TextEditingController();
  bool isPaybale = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void build(PktbsOrder arg) {}

  PktbsOrder get order => arg;

  void toggleIsPayable() {
    isPaybale = !isPaybale;
    ref.notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
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
  }

  void clear() {
    formKey = GlobalKey<FormState>();
    amountCntrlr.text = '0.0';
    descriptionCntrlr.clear();
    ref.notifyListeners();
  }
}
