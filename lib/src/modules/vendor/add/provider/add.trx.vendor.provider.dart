import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../transaction/model/transaction.dart';
import '../../model/vendor.trx.dart';

import '../../../../pocketbase/auth.store/helpers.dart';
import '../../../../shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../../../../shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../transaction/api/trx.api.dart';
import '../../../transaction/enum/trx.type.dart';
import '../../model/vendor.dart';

typedef AddTrxVendorNotifier
    = AutoDisposeNotifierProviderFamily<AddTrxVendorProvider, void, VendorTrx>;

final addTrxVendorProvider = AddTrxVendorNotifier(AddTrxVendorProvider.new);

class AddTrxVendorProvider extends AutoDisposeFamilyNotifier<void, VendorTrx> {
  final amountCntrlr = TextEditingController(text: '0.0');
  final descriptionCntrlr = TextEditingController();
  bool isPaybale = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void build(VendorTrx arg) {
    if (arg.trx != null) {
      amountCntrlr.text = arg.trx!.amount.toString();
      descriptionCntrlr.text = arg.trx!.description ?? '';
      isPaybale = arg.trx!.trxType == TrxType.credit;
    }
  }

  PktbsVendor get vendor => arg.vendor;

  void toggleIsPayable() {
    isPaybale = !isPaybale;
    ref.notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    if (arg.trx == null) {
      await pktbsAddTrx(
        context,
        fromId: pb.authStore.model?.id,
        fromJson: pb.authStore.model?.toJson(),
        fromType: GLType.user,
        toId: vendor.id,
        toJson: vendor.toJson(),
        toType: vendor.glType,
        amount: double.parse(amountCntrlr.text),
        trxType: isPaybale ? TrxType.credit : TrxType.debit,
        description: descriptionCntrlr.text,
        voucher: 'Vendor Transaction',
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
