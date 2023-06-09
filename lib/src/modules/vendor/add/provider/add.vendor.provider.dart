import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/vendor.api.dart';

typedef AddVendorNotifier
    = AutoDisposeNotifierProvider<AddVendorProvider, void>;

final addVendorProvider = AddVendorNotifier(AddVendorProvider.new);

class AddVendorProvider extends AutoDisposeNotifier<void> {
  final openingBalanceCntrlr = TextEditingController(text: '0.0');
  final descriptionCntrlr = TextEditingController();
  final addressCntrlr = TextEditingController();
  final emailCntrlr = TextEditingController();
  final phoneCntrlr = TextEditingController();
  final nameCntrlr = TextEditingController();
  bool isPaybale = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void build() {}

  void toggleIsPayable() {
    isPaybale = !isPaybale;
    ref.notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    await pktbsAddVendor(context, this);
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
