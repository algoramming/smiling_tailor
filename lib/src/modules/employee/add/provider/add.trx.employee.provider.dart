import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/employee/model/employee.dart';
import 'package:smiling_tailor/src/modules/transaction/api/add.trx.employee.api.dart';

typedef AddTrxEmployeeNotifier = AutoDisposeNotifierProviderFamily<
    AddTrxEmployeeProvider, void, PktbsEmployee>;

final addTrxEmployeeProvider = AddTrxEmployeeNotifier(AddTrxEmployeeProvider.new);

class AddTrxEmployeeProvider
    extends AutoDisposeFamilyNotifier<void, PktbsEmployee> {
  final TextEditingController amountCntrlr = TextEditingController(text: '0.0');
  final TextEditingController descriptionCntrlr = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void build(PktbsEmployee arg) {}

  PktbsEmployee get employee => arg;

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    await pktbsAddTrxEmployee(context, this);
  }

  void clear() {
    formKey = GlobalKey<FormState>();
    amountCntrlr.text = '0.0';
    descriptionCntrlr.clear();
    ref.notifyListeners();
  }
}
