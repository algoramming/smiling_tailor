import 'package:flutter/material.dart';
import 'package:smiling_tailor/src/modules/employee/add/view/add.employee.popup.dart';

import 'components/employee.details.dart';
import 'components/employee.list.dart';

class EmployeeView extends StatelessWidget {
  const EmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            children: [
              Expanded(flex: 3, child: EmployeeList()),
              SizedBox(width: 6.0),
              Expanded(flex: 5, child: EmployeeDetails()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        tooltip: 'Add Employee',
        onPressed: () async => await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AddEmployeePopup(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
