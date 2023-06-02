import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../pocketbase/error.handle/error.handle.func.dart';
import '../../../shared/show_toast/awesome_snackbar.dart';
import '../../../shared/show_toast/show_toast.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/logger/logger_helper.dart';
import '../add/provider/add.inventory.provider.dart';

Future<void> pktbsAddInventory(
    BuildContext context, AddInventoryProvider notifier) async {
  try {
    await pb.collection(inventories).create(
      body: {
        'title': notifier.titleCntrlr.text,
        'description': notifier.descriptionCntrlr.text,
        'quantity': notifier.quantityCntrlr.text.toInt,
        'unit': notifier.unit?.name,
        'amount': notifier.amountCntrlr.text.toDouble,
        'advance': notifier.advanceCntrlr.text.toDouble,
        'creator': pb.authStore.model?.id,
        'from': notifier.from?.id,
      },
    ).then((_) async {
      notifier.clear();
      context.pop();
      showAwesomeSnackbar(context, 'Success!', 'Inventory added successfully.',
          MessageType.success);
    });
    return;
  } on ClientException catch (e) {
    log.e('Inventory Creation: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}
