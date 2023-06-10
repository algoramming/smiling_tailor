import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    EasyLoading.show(status: 'Creating inventory...');
    await pb.collection(inventories).create(
      body: {
        'title': notifier.titleCntrlr.text,
        'description': notifier.descriptionCntrlr.text,
        'quantity': notifier.quantityCntrlr.text.toInt,
        'unit': notifier.unit?.name,
        'amount': notifier.amountCntrlr.text.toDouble,
        'creator': pb.authStore.model?.id,
        'from': notifier.from?.id,
      },
    ).then((r) async => await pb
            .collection(inventories)
            .getOne(r.toJson()['id'], expand: pktbsInventoryExpand)
            .then((i) async {
          final inven = PktbsInventory.fromJson(i.toJson());
          log.i('Need Goods Trx for ${inven.title} of ${inven.from.name}');
          await pktbsAddTrx(
            context,
            fromId: inven.from.id,
            fromJson: inven.from.toJson(),
            fromType: inven.from.glType,
            toId: inven.id,
            toJson: inven.toJson(),
            toType: inven.glType,
            trxType: TrxType.debit,
            amount: inven.quantity.toString().toDouble,
            description: 'System Generated: goods! of ${inven.title}',
            isGoods: true,
            isSystemGenerated: true,
            unit: inven.unit.name,
          ).then((_) async {
            // check another trx nedded or not
            if (notifier.advanceCntrlr.text.isNotNullOrEmpty() &&
                notifier.advanceCntrlr.text.toDouble != 0.0) {
              final advanceBalance = notifier.advanceCntrlr.text.toDouble;
              log.i('Need Another Trx for ${inven.title} of $advanceBalance}');
              await pktbsAddTrx(
                context,
                fromId: pb.authStore.model?.id,
                fromJson: pb.authStore.model?.toJson(),
                fromType: GLType.user,
                toId: inven.id,
                toJson: inven.toJson(),
                toType: inven.glType,
                trxType: TrxType.credit,
                amount: advanceBalance,
                description:
                    'System Generated: advance amount! of ${inven.title}',
              ).then((_) {
                notifier.clear();
                context.pop();
                showAwesomeSnackbar(context, 'Success!',
                    'Inventory added successfully.', MessageType.success);
              });
            } else {
              log.i('No Trx needed!');
              notifier.clear();
              context.pop();
              showAwesomeSnackbar(context, 'Success!',
                  'Inventory added successfully.', MessageType.success);
            }
          });
        }));
    return;
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  } on ClientException catch (e) {
    log.e('Inventory Creation: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}
