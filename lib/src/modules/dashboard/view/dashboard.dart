import 'package:flutter/material.dart';

import 'components/all.user.list.dart';
import 'components/graph.summary.dart';
import 'components/order.status.summary.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                OrderStatusSummary(),
                Expanded(child: GraphSummary()),
              ],
            ),
          ),
          Expanded(flex: 2, child: AllUsersList()),
        ],
      ),
    );
  }
}
