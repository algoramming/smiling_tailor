import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../db/db.dart';
import '../../../pocketbase/auth.store/helpers.dart';
import '../../../pocketbase/error.handle/error.handle.func.dart';
import '../../../shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../../../shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/logger/logger_helper.dart';
import '../../transaction/api/trx.api.dart';
import '../../transaction/enum/trx.type.dart';
import '../../transaction/model/transaction.dart';
import '../../vendor/model/vendor.dart';
import '../add/provider/add.inventory.provider.dart';
import '../model/inventory.dart';

Future<void> pktbsUpdateInventory(
    BuildContext context, AddInventoryProvider notifier) async {
  try {
    EasyLoading.show(status: 'Updating inventory...');
    await pb.collection(inventories).update(
      notifier.arg!.id,
      body: {
        'from': notifier.from?.id,
        'unit': notifier.unit?.name,
        'updator': pb.authStore.model?.id,
        'title': notifier.titleCntrlr.text,
        'amount': notifier.amountCntrlr.text.toDouble,
        'description': notifier.descriptionCntrlr.text,
        'quantity': notifier.quantityCntrlr.text.toInt,
      },
    ).then((r) async => await pb
            .collection(inventories)
            .getOne(r.toJson()['id'], expand: pktbsInventoryExpand)
            .then((i) async {
          final inven = PktbsInventory.fromJson(i.toJson());
          log.i('Need Goods Trx for ${inven.title} of ${inven.from.name}');
          // trx for entry the inventories to the system
          await pktbsUpdateTrx(
            context,
            notifier.inventoryTrx!.copyWith(
              fromId: inven.from.id,
              from: inven.from.toJson(),
              toId: inven.id,
              to: inven.toJson(),
              trxType: TrxType.debit,
              amount: inven.quantity.toString().toDouble,
              description:
                  'System Generated: Transaction for Goods Entry! ${inven.title} [${inven.id}] - ${appCurrency.symbol}${inven.amount} has been added to the system through ${inven.from.name} [${inven.from.id}].',
              isGoods: true,
              voucher: 'Inventory Entry Transaction',
              isSystemGenerated: true,
              unit: inven.unit,
            ),
          ).then((_) async {
            // check another trx nedded or not
            // if (notifier.advanceCntrlr.text.isNotNullOrEmpty &&
            //     notifier.advanceCntrlr.text.toDouble != 0.0) {
            final advanceBalance = notifier.advanceCntrlr.text.toDouble;
            log.i('Need Another Trx for ${inven.title} of $advanceBalance}');
            // trx of advance amount
            await pktbsUpdateTrx(
              context,
              notifier.advanceTrx!.copyWith(
                fromId: inven.from.id,
                from: inven.from.toJson(),
                toId: inven.id,
                to: inven.toJson(),
                trxType: TrxType.credit,
                isSystemGenerated: true,
                amount: advanceBalance,
                voucher: 'Inventory Advance Amount Transaction',
                description:
                    'System Generated: Transaction for Advance Amount! ${inven.title} [${inven.id}] - ${inven.quantity}${inven.unit.symbol} has been added to the system through ${inven.from.name} [${inven.from.id}].',
              ),
            ).then((_) {
              notifier.clear();
              context.pop();
              showAwesomeSnackbar(context, 'Success!',
                  'Inventory updated successfully.', MessageType.success);
            });
            // } else {
            //   log.i('No Trx needed!');
            //   notifier.clear();
            //   context.pop();
            //   showAwesomeSnackbar(context, 'Success!',
            //       'Inventory added successfully.', MessageType.success);
            // }
          });
        }));
    return;
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  } on ClientException catch (e) {
    log.e('Inventory Updation: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}
