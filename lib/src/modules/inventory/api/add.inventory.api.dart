import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:smiling_tailor/src/modules/vendor/model/vendor.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../pocketbase/error.handle/error.handle.func.dart';
import '../../../shared/show_toast/awesome_snackbar.dart';
import '../../../shared/show_toast/show_toast.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/logger/logger_helper.dart';
import '../../transaction/api/add.trx.api.dart';
import '../../transaction/enum/trx.type.dart';
import '../add/provider/add.inventory.provider.dart';
import '../model/inventory.dart';

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
        // 'advance': notifier.advanceCntrlr.text.toDouble,
        'creator': pb.authStore.model?.id,
        'from': notifier.from?.id,
      },
    ).then((r) async {
      // check trx nedded or not
      if (notifier.advanceCntrlr.text.isNotNullOrEmpty() &&
          notifier.advanceCntrlr.text.toDouble != 0.0) {
        final advanceBalance = notifier.advanceCntrlr.text.toDouble;
        await pb
            .collection(inventories)
            .getOne(r.toJson()['id'], expand: pktbsInventoryExpand)
            .then((i) async {
          final inven = PktbsInventory.fromJson(i.toJson());
          log.i('Need Trx for ${inven.title} of $advanceBalance}');
          await pktbsAddTrx(
            context,
            fromId: notifier.from!.id,
            fromJson: notifier.from!.toJson(),
            fromType: notifier.from!.glType,
            toId: inven.id,
            toJson: inven.toJson(),
            toType: inven.glType,
            amount: advanceBalance,
            trxType: TrxType.payable,
            description: 'System Generated: advance amount! of ${inven.title}',
          ).then((value) {
            notifier.clear();
            context.pop();
            showAwesomeSnackbar(context, 'Success!',
                'Inventory added successfully.', MessageType.success);
          });
        });
      } else {
        log.i('No Trx needed!');
        notifier.clear();
        context.pop();
        showAwesomeSnackbar(context, 'Success!',
            'Inventory added successfully.', MessageType.success);
      }
    });
    return;
  } on ClientException catch (e) {
    log.e('Inventory Creation: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}
