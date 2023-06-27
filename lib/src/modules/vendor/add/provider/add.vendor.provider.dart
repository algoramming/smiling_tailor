import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../transaction/enum/trx.type.dart';
import '../../../transaction/model/transaction.dart';

import '../../../transaction/provider/all.trxs.provider.dart';
import '../../api/vendor.api.dart';
import '../../model/vendor.dart';

typedef AddVendorNotifier = AutoDisposeAsyncNotifierProviderFamily<
    AddVendorProvider, void, PktbsVendor?>;

final addVendorProvider = AddVendorNotifier(AddVendorProvider.new);

class AddVendorProvider
    extends AutoDisposeFamilyAsyncNotifier<void, PktbsVendor?> {
  final openingBalanceCntrlr = TextEditingController(text: '0.0');
  final descriptionCntrlr = TextEditingController();
  final addressCntrlr = TextEditingController();
  final emailCntrlr = TextEditingController();
  final phoneCntrlr = TextEditingController();
  final nameCntrlr = TextEditingController();
  bool isPaybale = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  PktbsTrx? openingTrx;

  @override
  FutureOr<void> build(PktbsVendor? arg) async {
    if (arg != null) {
      final trxs = await ref.watch(allTrxsProvider.future);
      openingTrx = trxs.any(
        (trx) =>
            trx.isActive &&
            trx.isSystemGenerated &&
            trx.fromType.isUser &&
            trx.toId == arg.id,
      )
          ? trxs.firstWhere(
              (trx) =>
                  trx.isActive &&
                  trx.isSystemGenerated &&
                  trx.fromType.isUser &&
                  trx.toId == arg.id,
            )
          : null;
      openingBalanceCntrlr.text = openingTrx?.amount.toString() ?? '0.0';
      descriptionCntrlr.text = arg.description;
      addressCntrlr.text = arg.address;
      emailCntrlr.text = arg.email ?? '';
      phoneCntrlr.text = arg.phone;
      nameCntrlr.text = arg.name;
      isPaybale = openingTrx?.trxType.isDebit ?? false;
    }
  }

  void toggleIsPayable() {
    isPaybale = !isPaybale;
    ref.notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    if (arg != null) {
      await pktbsUpdateVendor(context, this);
    } else {
      await pktbsAddVendor(context, this);
    }
  }

  void clear() {
    formKey = GlobalKey<FormState>();
    openingBalanceCntrlr.text = '0.0';
    descriptionCntrlr.clear();
    addressCntrlr.clear();
    emailCntrlr.clear();
    phoneCntrlr.clear();
    nameCntrlr.clear();
    ref.notifyListeners();
  }
}
