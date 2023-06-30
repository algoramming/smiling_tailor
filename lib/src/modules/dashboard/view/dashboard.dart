import 'package:flutter/material.dart';

import '../../../config/constants.dart';
import 'components/all.user.list.dart';
import 'components/get.customers.info.dart';
import 'components/order.status.summary.dart';
import 'components/trxs.graph.summary.dart';

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
                  SizedBox(height: 50.0),
                  TrxsGraphSummary(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                GetCustomersInfo(),
                AllUsersList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
