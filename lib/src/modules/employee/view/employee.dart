import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/transations/big.to.small.dart';
import '../add/view/add.employee.popup.dart';
import '../provider/employee.provider.dart';
import 'components/employee.details.dart';
import 'components/employee.list.dart';

class EmployeeView extends StatelessWidget {
  const EmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Row(
          children: [
            Expanded(flex: 3, child: EmployeeList()),
            SizedBox(width: 6.0),
            Expanded(flex: 5, child: EmployeeDetails()),
          ],
        ),
      ),
      floatingActionButton: Consumer(builder: (_, ref, __) {
        ref.watch(employeeProvider);
        final notifier = ref.watch(employeeProvider.notifier).selectedEmployee;
        return BigToSmallTransition(
          child: notifier != null
              ? const SizedBox.shrink()
              : FloatingActionButton.small(
                  tooltip: 'Add Employee',
                  onPressed: () async => await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const AddEmployeePopup(),
                  ),
                  child: const Icon(Icons.add),
                ),
        );
      }),
    );
  }
}
