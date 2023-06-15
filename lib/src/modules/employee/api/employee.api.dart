import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../pocketbase/error.handle/error.handle.func.dart';
import '../../../shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../../../shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
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
        'creator': pb.authStore.model!.id,
        'email': notifier.emailCntrlr.text,
        'phone': notifier.phoneCntrlr.text,
        'address': notifier.addressCntrlr.text,
        'description': notifier.descriptionCntrlr.text,
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
