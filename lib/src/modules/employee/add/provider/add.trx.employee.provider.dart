import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../pocketbase/auth.store/helpers.dart';
import '../../../../shared/show_toast/awesome_snackbar.dart';
import '../../../../shared/show_toast/show_toast.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../transaction/api/add.trx.api.dart';
import '../../../transaction/enum/trx.type.dart';
import '../../model/employee.dart';

typedef AddTrxEmployeeNotifier = AutoDisposeNotifierProviderFamily<
    AddTrxEmployeeProvider, void, PktbsEmployee>;

final addTrxEmployeeProvider =
    AddTrxEmployeeNotifier(AddTrxEmployeeProvider.new);

class AddTrxEmployeeProvider
    extends AutoDisposeFamilyNotifier<void, PktbsEmployee> {
  final amountCntrlr = TextEditingController(text: '0.0');
  final descriptionCntrlr = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void build(PktbsEmployee arg) {}

  PktbsEmployee get employee => arg;

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    await pktbsAddTrx(
      context,
      fromId: pb.authStore.model?.id,
      fromJson: pb.authStore.model?.toJson(),
      fromType: GLType.user,
      toId: employee.id,
      toJson: employee.toJson(),
      toType: employee.glType,
      amount: double.parse(amountCntrlr.text),
      trxType: TrxType.credit,
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
