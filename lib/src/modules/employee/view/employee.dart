import 'package:flutter/material.dart';

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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
