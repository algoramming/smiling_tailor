import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../../db/isar.dart';
import '../../../settings/model/measurement/measurement.dart';
import '../../../vendor/model/vendor.dart';
import '../../../vendor/provider/vendor.provider.dart';
import '../../api/add.inventory.api.dart';

final lengthMeasurementsProvider = FutureProvider((_) async {
  final ms = await db.measurements.where().filter().unitOfEqualTo('Length').findAll();
  ms.removeWhere((element) => element.name == 'Mile');
  return ms;
});

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
  List<Measurement> measurements = [];
  List<PktbsVendor> vendors = [];
  PktbsVendor? createdFrom;
  Measurement? unit;

  @override
  FutureOr<void> build() {
    vendors = ref.watch(vendorProvider).value ?? [];
    measurements = ref.watch(lengthMeasurementsProvider).value ?? [];
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    await pktbsAddInventory(context, this);
  }

  void setCreatedFrom(PktbsVendor? value) {
    createdFrom = value;
    ref.notifyListeners();
  }

  void setUnit(Measurement? value) {
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
    createdFrom = null;
    unit = null;
    ref.notifyListeners();
  }
}
