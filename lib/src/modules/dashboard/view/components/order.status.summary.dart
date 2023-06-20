import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/dashboard/provider/order.status.provider.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../../config/constants.dart';
import '../../../order/enum/order.enum.dart';

class OrderStatusSummary extends ConsumerWidget {
  const OrderStatusSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(orderStatusProvider);
    final notifier = ref.watch(orderStatusProvider.notifier);
    return Wrap(
      children: [
        for (final status in OrderStatus.values)
          InkWell(
            onTap: () => notifier.goToOrderTab(status),
            borderRadius: borderRadius12,
            child: Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: borderRadius12,
                border: Border.all(
                  color: context.theme.dividerColor,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: mainMin,
                mainAxisAlignment: mainCenter,
                children: [
                  Text(
                    status.label,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    notifier.getCustomOrders(status).length.toString(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
