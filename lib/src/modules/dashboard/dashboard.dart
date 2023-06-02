import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../shared/dash.flutter.muscot/dash.flutter.muscot.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: mainMin,
        mainAxisAlignment: mainCenter,
        children: [
          DashFlutterMuscot(),
          Text(
            '$appName - Dashboard',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
