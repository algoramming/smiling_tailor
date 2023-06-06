import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../pocketbase/error.handle/error.handle.func.dart';
import '../../../shared/show_toast/awesome_snackbar.dart';
import '../../../shared/show_toast/show_toast.dart';
import '../../../utils/logger/logger_helper.dart';
import '../enum/trx.type.dart';

// Future<void> pktbsAddTrxEmployee(
//     BuildContext context, AddTrxEmployeeProvider notifier) async {
//   try {
//     final employee = notifier.employee;
//     await pb.collection(transactions).create(
//       body: {
//         'gl': employee.toJson(),
//         'type': GLType.employee.title,
//         'amount': notifier.amountCntrlr.text.toDouble ?? 0.0,
//         'creator': pb.authStore.model?.id,
//         'gl_id': employee.id,
//         'description': notifier.descriptionCntrlr.text,
//       },
//     ).then((_) async {
//       notifier.clear();
//       context.pop();
//       showAwesomeSnackbar(context, 'Success!',
//           'Transaction added successfully.', MessageType.success);
//     });
//     return;
//   } on ClientException catch (e) {
//     log.e('Transaction Creation: $e');
//     showAwesomeSnackbar(
//         context, 'Failed!', getErrorMessage(e), MessageType.failure);
//     return;
//   }
// }

Future<RecordModel?> pktbsAddTrx(
  BuildContext context, {
  required Map<String, dynamic> glJson,
  required String glId,
  required GLType type,
  String? description,
  double? amount,
}) async {
  try {
    return await pb.collection(transactions).create(
      body: {
        'gl': glJson,
        'gl_id': glId,
        'type': type.title,
        'amount': amount ?? 0.0,
        'description': description,
        'creator': pb.authStore.model?.id,
      },
    );
  } on ClientException catch (e) {
    log.e('Transaction Creation: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return null;
  }
}
