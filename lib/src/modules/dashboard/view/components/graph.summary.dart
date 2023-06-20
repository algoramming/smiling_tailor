import 'package:flutter/material.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../../config/constants.dart';

class GraphSummary extends StatelessWidget {
  const GraphSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(
            '$appName - Dashboard',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
