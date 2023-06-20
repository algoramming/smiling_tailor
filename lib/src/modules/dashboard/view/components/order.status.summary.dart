import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/dashboard/provider/order.status.provider.dart';
import 'package:smiling_tailor/src/modules/order/provider/order.provider.dart';
import 'package:smiling_tailor/src/shared/radio_button/k_radio_button.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../../config/constants.dart';
import '../../../order/enum/order.enum.dart';

class OrderStatusSummary extends ConsumerWidget {
  const OrderStatusSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(orderStatusProvider);
    final notifier = ref.watch(orderStatusProvider.notifier);
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Order Summary',
                style: context.text.titleLarge,
              ),
              const Spacer(),
              Text(
                '...till now total: ${notifier.rawOrders.length} Orders',
                style: context.text.labelMedium,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          if (notifier.todayDeliveriableOrders.isNotEmpty)
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'You have total',
                    style: context.text.labelMedium,
                  ),
                  TextSpan(
                    text:
                        ' ${notifier.todayDeliveriableOrders.length} ${notifier.todayDeliveriableOrders.length > 1 ? 'orders ' : 'order '} ',
                    style: context.text.titleLarge!
                        .copyWith(color: context.theme.primaryColor),
                  ),
                  TextSpan(
                    text: 'to deliver today.',
                    style: context.text.labelMedium,
                  ),
                ],
              ),
            ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: mainSpaceAround,
            children: [
              KRadioButton(
                value: 0,
                label: 'Overall',
                groupValue: notifier.summaryRadio,
                onTap: notifier.changeSummaryRadio,
              ),
              KRadioButton(
                value: 1,
                label: 'Today',
                groupValue: notifier.summaryRadio,
                onTap: notifier.changeSummaryRadio,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              for (final status in [
                orderDeliveryDateToday,
                ...OrderStatus.values.map((e) => e.label).toList(),
              ])
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
                          status,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          status == orderDeliveryDateToday
                              ? notifier.todayDeliveriableOrders.length
                                  .toString()
                              : notifier
                                  .getCustomOrders(status)
                                  .length
                                  .toString(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
