import 'package:flutter/material.dart';

import '../../../config/constants.dart';
import 'components/all.user.list.dart';
import 'components/trxs.graph.summary.dart';
import 'components/order.status.summary.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Row(
        crossAxisAlignment: crossStart,
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  OrderStatusSummary(),
                  TrxsGraphSummary(),
                ],
              ),
            ),
          ),
          Expanded(flex: 2, child: AllUsersList()),
        ],
      ),
    );
  }
}
