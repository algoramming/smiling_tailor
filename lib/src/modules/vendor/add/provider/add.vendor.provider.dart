import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../api/vendor.api.dart';

typedef AddVendorNotifier
    = AutoDisposeNotifierProvider<AddVendorProvider, void>;

final addVendorProvider = AddVendorNotifier(AddVendorProvider.new);

class AddVendorProvider extends AutoDisposeNotifier<void> {
  final TextEditingController openingBalanceCntrlr =
      TextEditingController(text: '0.0');
  final TextEditingController descriptionCntrlr = TextEditingController();
  final TextEditingController addressCntrlr = TextEditingController();
  final TextEditingController emailCntrlr = TextEditingController();
  final TextEditingController phoneCntrlr = TextEditingController();
  final TextEditingController nameCntrlr = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void build() {}

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
