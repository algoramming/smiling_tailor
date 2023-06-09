import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../db/isar.dart';
import '../../../settings/model/measurement/measurement.dart';
import '../../../vendor/model/vendor.dart';
import '../../../vendor/provider/vendor.provider.dart';
import '../../api/add.inventory.api.dart';

// final lengthMeasurementsProvider = FutureProvider((_) async {
//   final ms =
//       await db.measurements.where().filter().unitOfEqualTo('Length').findAll();
//   ms.removeWhere((element) => element.name == 'Mile');
//   return ms;
// });

typedef AddInventoryNotifier
    = AutoDisposeAsyncNotifierProvider<AddInventoryProvider, void>;

final addInventoryProvider = AddInventoryNotifier(AddInventoryProvider.new);

class AddInventoryProvider extends AutoDisposeAsyncNotifier<void> {
  final quantityCntrlr = TextEditingController(text: '0');
  final advanceCntrlr = TextEditingController(text: '0.0');
  final amountCntrlr = TextEditingController(text: '0.0');
  final descriptionCntrlr = TextEditingController();
  final titleCntrlr = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Measurement> measurements = [];
  List<PktbsVendor> vendors = [];
  PktbsVendor? from;
  Measurement? unit;

  @override
  FutureOr<void> build() {
    vendors = ref.watch(vendorProvider).value ?? [];
    // measurements = ref.watch(lengthMeasurementsProvider).value ?? [];
    measurements = appMeasurements
        .where((e) => e.unitOf == 'Length' && e.name != 'Mile')
        .toList();
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    await pktbsAddInventory(context, this);
  }

  void setCreatedFrom(PktbsVendor? value) {
    from = value;
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
    from = null;
    unit = null;
    ref.notifyListeners();
  }
}
