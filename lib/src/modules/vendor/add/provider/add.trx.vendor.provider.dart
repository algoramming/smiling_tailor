import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../pocketbase/auth.store/helpers.dart';
import '../../../../shared/show_toast/awesome_snackbar.dart';
import '../../../../shared/show_toast/show_toast.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../transaction/api/add.trx.api.dart';
import '../../../transaction/enum/trx.type.dart';
import '../../model/vendor.dart';

typedef AddTrxVendorNotifier = AutoDisposeNotifierProviderFamily<
    AddTrxVendorProvider, void, PktbsVendor>;

final addTrxVendorProvider = AddTrxVendorNotifier(AddTrxVendorProvider.new);

class AddTrxVendorProvider
    extends AutoDisposeFamilyNotifier<void, PktbsVendor> {
  final amountCntrlr = TextEditingController(text: '0.0');
  final descriptionCntrlr = TextEditingController();
  bool isPaybale = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void build(PktbsVendor arg) {}

  PktbsVendor get vendor => arg;

  void toggleIsPayable() {
    isPaybale = !isPaybale;
    ref.notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
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
