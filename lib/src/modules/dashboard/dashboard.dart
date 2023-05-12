import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '$appName - Dashboard',
        textAlign: TextAlign.center,
      ),
    );
  }
}
