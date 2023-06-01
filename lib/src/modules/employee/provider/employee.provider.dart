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
    _employees = await pb
        .collection(employees)
        .getFullList(expand: 'creator, updator')
        .then((v) {
      log.i('Employees: $v');
      return v.map((e) => PktbsEmployee.fromJson(e.toJson())).toList();
    });

    return _employees;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  _stream() {
    // Implement Stream needs pocketbase update to add filter and expand options then the autodispose had to remove
    pb.collection(employees).subscribe('*', (s) async {
      log.i('Stream $s');
      await pb
          .collection(employees)
          .getOne(s.record!.toJson()['id'], expand: 'creator, updator')
          .then((emp) {
        log.i('Stream After Get Employee: $emp');
        if (s.action == 'create') {
          _employees.add(PktbsEmployee.fromJson(emp.toJson()));
        } else if (s.action == 'update') {
          _employees.removeWhere((e) => e.id == emp.id);
          _employees.add(PktbsEmployee.fromJson(emp.toJson()));
        } else if (s.action == 'delete') {
          _employees.removeWhere((e) => e.id == emp.id);
        }
        ref.notifyListeners();
      });
    });
  }

  List<PktbsEmployee> get employeeList {
    _employees
        .sort((a, b) => b.created.toLocal().compareTo(a.created.toLocal()));
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
