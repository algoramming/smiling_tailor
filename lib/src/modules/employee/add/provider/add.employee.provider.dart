import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/employee.api.dart';
import '../../model/employee.dart';

typedef AddEmployeeNotifier = AutoDisposeNotifierProviderFamily<
    AddEmployeeProvider, void, PktbsEmployee?>;

final addEmployeeProvider = AddEmployeeNotifier(AddEmployeeProvider.new);

class AddEmployeeProvider
    extends AutoDisposeFamilyNotifier<void, PktbsEmployee?> {
  final salaryCntrlr = TextEditingController(text: '0.0');
  final descriptionCntrlr = TextEditingController();
  final addressCntrlr = TextEditingController();
  final emailCntrlr = TextEditingController();
  final phoneCntrlr = TextEditingController();
  final nameCntrlr = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void build(PktbsEmployee? arg) {
    if (arg != null) {
      salaryCntrlr.text = arg.salary.toString();
      descriptionCntrlr.text = arg.description;
      addressCntrlr.text = arg.address;
      emailCntrlr.text = arg.email ?? '';
      phoneCntrlr.text = arg.phone;
      nameCntrlr.text = arg.name;
    }
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    if (arg != null) {
      await pktbsUpdateEmployee(context, this);
    } else {
      await pktbsAddEmployee(context, this);
    }
  }

  void clear() {
    formKey = GlobalKey<FormState>();
    salaryCntrlr.text = '0.0';
    descriptionCntrlr.clear();
    addressCntrlr.clear();
    emailCntrlr.clear();
    phoneCntrlr.clear();
    nameCntrlr.clear();
    ref.notifyListeners();
  }
}
