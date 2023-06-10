import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../pocketbase/error.handle/error.handle.func.dart';
import '../../../shared/show_toast/awesome_snackbar.dart';
import '../../../shared/show_toast/show_toast.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/logger/logger_helper.dart';
import '../add/provider/add.employee.provider.dart';

Future<void> pktbsAddEmployee(
    BuildContext context, AddEmployeeProvider notifier) async {
  try {
    EasyLoading.show(status: 'Creating employee...');
    await pb.collection(employees).create(
      body: {
        'name': notifier.nameCntrlr.text,
        'address': notifier.addressCntrlr.text,
        'description': notifier.descriptionCntrlr.text,
        'email': notifier.emailCntrlr.text,
        'phone': notifier.phoneCntrlr.text,
        'creator': pb.authStore.model!.id,
        'salary': notifier.salaryCntrlr.text.toDouble ?? 0.0,
      },
    ).then((_) async {
      notifier.clear();
      context.pop();
      showAwesomeSnackbar(context, 'Success!', 'Employee created successfully.',
          MessageType.success);
    });
    return;
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  } on ClientException catch (e) {
    log.e('Employee Creation: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}
