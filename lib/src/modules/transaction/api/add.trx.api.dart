import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../pocketbase/error.handle/error.handle.func.dart';
import '../../../shared/show_toast/awesome_snackbar.dart';
import '../../../shared/show_toast/show_toast.dart';
import '../../../utils/logger/logger_helper.dart';
import '../enum/trx.type.dart';

Future<RecordModel?> pktbsAddTrx(
  BuildContext context, {
  required String fromId,
  required Map<String, dynamic> fromJson,
  required GLType fromType,
  required String toId,
  required Map<String, dynamic> toJson,
  required GLType toType,
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
        'from_id': fromId,
        'from': fromJson,
        'fromType': fromType.title,
        'to_id': toId,
        'to': toJson,
        'toType': toType.title,
        'amount': amount ?? 0.0,
        'unit': unit,
        'isGoods': isGoods,
        'trxType': trxType.title,
        'description': description,
        'isSystemGenerated': isSystemGenerated,
        'creator': pb.authStore.model?.id,
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
