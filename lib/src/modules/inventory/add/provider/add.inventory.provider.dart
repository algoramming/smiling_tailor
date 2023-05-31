import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/vendor/provider/vendor.provider.dart';

import '../../../vendor/model/vendor.dart';

typedef AddInventoryNotifier
    = AutoDisposeAsyncNotifierProvider<AddInventoryProvider, void>;

final addInventoryProvider = AddInventoryNotifier(AddInventoryProvider.new);

class AddInventoryProvider extends AutoDisposeAsyncNotifier<void> {
  final TextEditingController quantityCntrlr = TextEditingController(text: '0');
  final TextEditingController advanceCntrlr =
      TextEditingController(text: '0.0');
  final TextEditingController amountCntrlr = TextEditingController(text: '0.0');
  final TextEditingController descriptionCntrlr = TextEditingController();
  final TextEditingController titleCntrlr = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PktbsVendor? createdForm;
  String? unit;
  List<PktbsVendor> vendors = [];

  @override
  FutureOr<void> build() {
    vendors = ref.watch(vendorProvider).value ?? [];
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    // await pktbsAddEmployee(context, this);
  }

  void setCreatedForm(PktbsVendor? value) {
    createdForm = value;
    ref.notifyListeners();
  }

  void setUnit(String? value) {
    unit = value;
    ref.notifyListeners();
  }

  void clear() {
    formKey = GlobalKey<FormState>();
    descriptionCntrlr.clear();
    quantityCntrlr.clear();
    advanceCntrlr.clear();
    amountCntrlr.clear();
    titleCntrlr.clear();
    createdForm = null;
    unit = null;
    ref.notifyListeners();
  }
}
