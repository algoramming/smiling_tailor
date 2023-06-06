import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../../shared/show_toast/awesome_snackbar.dart';
import '../../../../shared/show_toast/show_toast.dart';
import '../../../transaction/api/add.trx.employee.api.dart';
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
      glJson: employee.toJson(),
      glId: employee.id,
      type: GLType.employee,
      description: descriptionCntrlr.text,
      amount: double.parse(
        amountCntrlr.text,
      ),
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
