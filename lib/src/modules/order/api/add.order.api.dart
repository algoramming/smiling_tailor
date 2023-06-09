import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../pocketbase/error.handle/error.handle.func.dart';
import '../../../shared/show_toast/awesome_snackbar.dart';
import '../../../shared/show_toast/show_toast.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/logger/logger_helper.dart';
import '../add/provider/add.order.provider.dart';
import '../enum/order.enum.dart';

Future<void> pktbsAddOrder(
    BuildContext context, AddOrderProvider notifier) async {
  try {
    await pb.collection(orders).create(
      body: {
        'customerName': notifier.customerNameCntrlr.text,
        'customerEmail': notifier.customerEmailCntrlr.text,
        'customerPhone': notifier.customerPhoneCntrlr.text,
        'customerAddress': notifier.customerAddressCntrlr.text,
        'customerNote': notifier.customerNoteCntrlr.text,
        'measurement': notifier.measurementCntrlr.text,
        'plate': notifier.plateCntrlr.text,
        'sleeve': notifier.sleeveCntrlr.text,
        'colar': notifier.colarCntrlr.text,
        'pocket': notifier.pocketCntrlr.text,
        'button': notifier.buttonCntrlr.text,
        'measurementNote': notifier.measurementNoteCntrlr.text,
        'quantity': notifier.quantityCntrlr.text.toInt,
        'tailorEmployee': notifier.tailorEmployee!.id,
        'tailorCharge': notifier.tailorChargeCntrlr.text.toDouble,
        'tailorNote': notifier.tailorNoteCntrlr.text,
        'inventory': notifier.inventory!.id,
        'inventoryQuantity': notifier.inventoryQuantityCntrlr.text.toInt,
        'inventoryUnit': notifier.inventoryUnit!.name,
        'inventoryPrice': notifier.inventoryPriceCntrlr.text.toDouble,
        'inventoryNote': notifier.inventoryNoteCntrlr.text,
        'deliveryEmployee': notifier.deliveryEmployee?.id,
        'deliveryAddress': notifier.deliveryAddressCntrlr.text,
        'deliveryCharge': notifier.deliveryChargeCntrlr.text.toDouble,
        'deliveryNote': notifier.deliveryNoteCntrlr.text,
        'paymentMethod': notifier.paymentMethod.label,
        'paymentNote': notifier.paymentNoteCntrlr.text,
        'advanceAmount': notifier.advanceAmountCntrlr.text.toDouble,
        'deliveryTime': notifier.deliveryTime.toUtc().toIso8601String(),
        'description': notifier.descriptionCntrlr.text,
        'status': notifier.status.label,
        'creator': pb.authStore.model!.id
      },
    ).then((_) async {
      notifier.clear();
      context.pop();
      showAwesomeSnackbar(context, 'Success!', 'Order added successfully.',
          MessageType.success);
    });
    return;
  } on ClientException catch (e) {
    log.e('Order Creation: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}
