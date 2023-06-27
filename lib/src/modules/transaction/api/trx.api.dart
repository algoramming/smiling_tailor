import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../pocketbase/error.handle/error.handle.func.dart';
import '../../../shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../../../shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import '../../../utils/logger/logger_helper.dart';
import '../enum/trx.type.dart';
import '../model/transaction.dart';

Future<RecordModel?> pktbsAddTrx(
  BuildContext context, {
  required String fromId,
  required Map<String, dynamic> fromJson,
  required GLType fromType,
  required String toId,
  required Map<String, dynamic> toJson,
  required GLType toType,
  required String voucher,
  double? amount,
  required TrxType trxType,
  String? description,
  bool isSystemGenerated = false,
  String? unit,
  bool isGoods = false,
}) async {
  try {
    return await pb.collection(transactions).create(
      body: {
        'to': toJson,
        'unit': unit,
        'to_id': toId,
        'isActive': true,
        'from': fromJson,
        'from_id': fromId,
        'voucher': voucher,
        'isGoods': isGoods,
        'toType': toType.title,
        'amount': amount ?? 0.0,
        'trxType': trxType.title,
        'description': description,
        'fromType': fromType.title,
        'creator': pb.authStore.model?.id,
        'isSystemGenerated': isSystemGenerated,
      },
    );
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return null;
  } on ClientException catch (e) {
    log.e('Transaction Creation: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return null;
  }
}


Future<RecordModel?> pktbsUpdateTrx(BuildContext context, PktbsTrx trx) async {
  try {
    return await pb.collection(transactions).update(
      trx.id,
      body: {
        'to': trx.to,
        'from': trx.from,
        'unit': trx.unit,
        'to_id': trx.toId,
        'amount': trx.amount,
        'from_id': trx.fromId,
        'isGoods': trx.isGoods,
        'voucher': trx.voucher,
        'isActive': trx.isActive,
        'toType': trx.toType.title,
        'trxType': trx.trxType.title,
        'description': trx.description,
        'fromType': trx.fromType.title,
        'updator': pb.authStore.model?.id,
        'isSystemGenerated': trx.isSystemGenerated,
      },
    );
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return null;
  } on ClientException catch (e) {
    log.e('Transaction Creation: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return null;
  }
}
