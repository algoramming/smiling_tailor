import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../db/isar.dart';
import '../../../pocketbase/auth.store/helpers.dart';
import '../../../pocketbase/error.handle/error.handle.func.dart';
import '../../../shared/show_toast/awesome_snackbar.dart';
import '../../../shared/show_toast/show_toast.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/logger/logger_helper.dart';
import '../../transaction/api/add.trx.api.dart';
import '../../transaction/enum/trx.type.dart';
import '../add/provider/add.vendor.provider.dart';
import '../model/vendor.dart';

Future<void> pktbsAddVendor(
    BuildContext context, AddVendorProvider notifier) async {
  try {
    EasyLoading.show(status: 'Creating vendor...');
    await pb.collection(vendors).create(
      body: {
        'name': notifier.nameCntrlr.text,
        'address': notifier.addressCntrlr.text,
        'description': notifier.descriptionCntrlr.text,
        'email': notifier.emailCntrlr.text,
        'phone': notifier.phoneCntrlr.text,
        'creator': pb.authStore.model!.id,
      },
    ).then((r) async {
      // check trx nedded or not
      if (notifier.openingBalanceCntrlr.text.isNotNullOrEmpty() &&
          notifier.openingBalanceCntrlr.text.toDouble != 0.0) {
        final openingBalance = notifier.openingBalanceCntrlr.text.toDouble;
        await pb
            .collection(vendors)
            .getOne(r.toJson()['id'], expand: pktbsVendorExpand)
            .then((v) async {
          final ven = PktbsVendor.fromJson(v.toJson());
          log.i('Need Trx for ${ven.name} of $openingBalance}');
          await pktbsAddTrx(
            context,
            fromId: pb.authStore.model?.id,
            fromJson: pb.authStore.model?.toJson(),
            fromType: GLType.user,
            toId: ven.id,
            toJson: ven.toJson(),
            toType: ven.glType,
            trxType: notifier.isPaybale ? TrxType.debit : TrxType.credit,
            isSystemGenerated: true,
            amount: openingBalance,
            voucher: 'Vendor Opening Balance Transaction',
            description:
                'System Generated: Transaction for Opening Balance. ${ven.name} [${ven.id}] is ${!notifier.isPaybale ? 'Payable' : 'Receivable'} of ${appCurrency.symbol}$openingBalance. Liability ${notifier.isPaybale ? 'Credit/Increase' : 'Debit/Decrease'}.',
          ).then((value) {
            notifier.clear();
            context.pop();
            showAwesomeSnackbar(context, 'Success!',
                'Vendor added successfully.', MessageType.success);
          });
        });
      } else {
        log.i('No Trx needed!');
        notifier.clear();
        context.pop();
        showAwesomeSnackbar(context, 'Success!', 'Vendor added successfully.',
            MessageType.success);
      }
    });
    return;
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  } on ClientException catch (e) {
    log.e('Vendor Creation: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}
