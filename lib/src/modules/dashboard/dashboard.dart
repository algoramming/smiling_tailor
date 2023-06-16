import 'package:flutter/material.dart';
import '../../utils/extensions/extensions.dart';

import '../../config/constants.dart';
import '../../shared/dash.flutter.muscot/dash.flutter.muscot.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: borderRadius12,
                        border: Border.all(
                          color: context.theme.dividerColor,
                          width: 1,
                        ),
                      ),
                      child: const Column(
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
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: borderRadius12,
                        border: Border.all(
                          color: context.theme.dividerColor,
                          width: 1,
                        ),
                      ),
                      child: const Column(
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
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 2,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: borderRadius12,
                border: Border.all(
                  color: context.theme.dividerColor,
                  width: 1,
                ),
              ),
              child: const Column(
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
            ),
          ),
        ],
      ),
    );
  }
}
