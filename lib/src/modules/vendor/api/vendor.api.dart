import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import '../add/provider/add.vendor.provider.dart';
import '../../../utils/extensions/extensions.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../pocketbase/error.handle/error.handle.func.dart';
import '../../../shared/show_toast/awesome_snackbar.dart';
import '../../../shared/show_toast/show_toast.dart';
import '../../../utils/logger/logger_helper.dart';

Future<void> pktbsAddVendor(BuildContext context, AddVendorProvider notifier) async {
  try {
    await pb.collection(vendors).create(
      body: {
        'name': notifier.nameCntrlr.text,
        'address': notifier.addressCntrlr.text,
        'description': notifier.descriptionCntrlr.text,
        'email': notifier.emailCntrlr.text,
        'phone': notifier.phoneCntrlr.text,
        'opening_balance': notifier.openingBalanceCntrlr.text.toDouble ?? 0.0,
      },
    ).then((_) async {
      notifier.clear();
      context.pop();
      showAwesomeSnackbar(context, 'Success!', 'Vendor created successfully.',
          MessageType.success);
    });
    return;
  } on ClientException catch (e) {
    log.e('Vendor Creation: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}
