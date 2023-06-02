import 'package:flutter/material.dart';
import '../add/provider/add.order.provider.dart';

Future<void> pktbsAddOrder(
    BuildContext context, AddOrderProvider notifier) async {
  // try {
  //   await pb.collection(inventories).create(
  //     body: {
  //       'title': notifier.titleCntrlr.text,
  //       'description': notifier.descriptionCntrlr.text,
  //       'quantity': notifier.quantityCntrlr.text.toInt,
  //       'unit': notifier.unit?.name,
  //       'amount': notifier.amountCntrlr.text.toDouble,
  //       'advance': notifier.advanceCntrlr.text.toDouble,
  //       'creator': pb.authStore.model?.id,
  //       'from': notifier.createdFrom?.id,
  //     },
  //   ).then((_) async {
  //     notifier.clear();
  //     context.pop();
  //     showAwesomeSnackbar(context, 'Success!', 'Inventory added successfully.',
  //         MessageType.success);
  //   });
  //   return;
  // } on ClientException catch (e) {
  //   log.e('Inventory Creation: $e');
  //   showAwesomeSnackbar(
  //       context, 'Failed!', getErrorMessage(e), MessageType.failure);
  //   return;
  // }
}
