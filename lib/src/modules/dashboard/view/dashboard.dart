import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/authentication/model/user.dart';
import 'package:smiling_tailor/src/shared/page_not_found/page_not_found.dart';

import '../../../config/constants.dart';
import '../../../shared/loading_widget/loading_widget.dart';
import '../../profile/provider/profile.provider.dart';
import 'components/all.user.list.dart';
import 'components/get.customers.info.dart';
import 'components/order.status.summary.dart';
import 'components/trxs.graph.summary.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileProvider);
    if (user == null) return const LoadingWidget();
    if (user.isDispose || user.isManager) return const AccesDeniedPage();
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
