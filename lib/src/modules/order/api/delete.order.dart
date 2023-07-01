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

Future<bool> pktbsDeleteOrder(BuildContext context, String id) async {
  try {
    EasyLoading.show(status: 'Deleting order...');
    await pb.collection(orders).delete(id);
    return true;
  } on SocketException catch (e) {
    context.pop();
    context.pop();
    EasyLoading.showError('No Internet Connection. $e');
    return false;
  } on ClientException catch (e) {
    context.pop();
    context.pop();
    log.e('Order deletion: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return false;
  }
}
