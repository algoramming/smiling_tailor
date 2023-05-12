import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';

class EmployeeDetails extends StatelessWidget {
  const EmployeeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '$appName - Employees',
        textAlign: TextAlign.center,
      ),
    );
  }
}
