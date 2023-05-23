import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:smiling_tailor/src/modules/employee/model/employee.dart';
import 'package:smiling_tailor/src/modules/transaction/enum/trx.type.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../pocketbase/error.handle/error.handle.func.dart';
import '../../../shared/show_toast/awesome_snackbar.dart';
import '../../../shared/show_toast/show_toast.dart';
import '../../../utils/logger/logger_helper.dart';
import '../../employee/add/provider/add.trx.employee.provider.dart';

Future<void> pktbsAddTrxEmployee(
    BuildContext context, AddTrxEmployeeProvider notifier) async {
  try {
    final employee = notifier.employee;
    await pb.collection(transactions).create(
      body: {
        'gl': employee.toJson(),
        'type': GLType.employee.title,
        'amount': notifier.amountCntrlr.text.toDouble ?? 0.0,
        'created_by': pb.authStore.model?.id,
        'gl_id': employee.id,
        'updated_by': null,
        'description': notifier.descriptionCntrlr.text,
      },
    ).then((_) async {
      notifier.clear();
      context.pop();
      showAwesomeSnackbar(context, 'Success!',
          'Transaction added successfully.', MessageType.success);
    });
    return;
  } on ClientException catch (e) {
    log.e('Transaction Creation: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}
