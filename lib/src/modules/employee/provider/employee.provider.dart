import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../utils/logger/logger_helper.dart';
import '../model/employee.dart';

typedef EmployeeNotifier
    = AsyncNotifierProvider<EmployeeProvider, List<PktbsEmployee>>;

final employeeProvider = EmployeeNotifier(EmployeeProvider.new);

class EmployeeProvider extends AsyncNotifier<List<PktbsEmployee>> {
  TextEditingController searchCntrlr = TextEditingController();
  PktbsEmployee? selectedEmployee;
  late List<PktbsEmployee> _employees;
  @override
  FutureOr<List<PktbsEmployee>> build() async {
    _employees = [];
    _listener();
    _stream();
    _employees = await pb.collection(employees).getFullList().then((v) {
      log.i('Employees: $v');
      return v.map((e) {
        log.wtf('Vendor: $e');
        return PktbsEmployee.fromJson(e.toJson());
      }).toList();
    });

    return _employees;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  _stream() {
    pb.collection(employees).subscribe('*', (s) {
      log.i('Stream ${s.toJson()}');
      if (s.action == 'create') {
        _employees.add(PktbsEmployee.fromJson(s.record!.toJson()));
      } else if (s.action == 'update') {
        _employees.removeWhere((e) => e.id == s.record!.id);
        _employees.add(PktbsEmployee.fromJson(s.record!.toJson()));
      } else if (s.action == 'delete') {
        _employees.removeWhere((e) => e.id == s.record!.id);
      }
      ref.notifyListeners();
    });
  }

  List<PktbsEmployee> get employeeList {
    _employees.sort((a, b) => b.created.compareTo(a.created));
    final vs = _employees;
    return vs
        .where((e) =>
            e.name.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.address.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.phone.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            (e.email?.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ??
                false))
        .toList();
  }

  void selectEmployee(PktbsEmployee employee) {
    selectedEmployee = employee;
    ref.notifyListeners();
  }
}
