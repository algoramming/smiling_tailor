import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/constants.dart';
import '../../../../shared/gradient/gradient.widget.dart';
import '../../../../shared/radio_button/k_radio_button.dart';
import '../../../../shared/text.size/text.size.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../order/enum/order.enum.dart';
import '../../../order/provider/order.provider.dart';
import '../../provider/order.status.provider.dart';

class OrderStatusSummary extends ConsumerWidget {
  const OrderStatusSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(orderStatusProvider);
    final notifier = ref.watch(orderStatusProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Builder(builder: (_) {
            final width = calculateTextSize('Order Summary',
                    style: context.text.titleLarge)
                .width;
            return Row(
              mainAxisAlignment: mainCenter,
              children: [
                Column(
                  children: [
                    Text(
                      'Order Summary',
                      style: context.text.titleLarge,
                    ),
                    const SizedBox(height: 2.0),
                    GradientWidget(
                      child: Container(
                        height: 1.8,
                        width: width,
                        color: context.theme.primaryColor.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    GradientWidget(
                      child: Container(
                        height: 1.8,
                        width: width,
                        color: context.theme.primaryColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  '...till now total: ${notifier.rawOrders.length} Orders',
                  style: context.text.labelMedium,
                ),
              ],
            );
          }),
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
            mainAxisAlignment: mainSpaceEvenly,
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
                ...OrderStatus.values.map((e) => e.label),
              ])
                InkWell(
                  onTap: () => notifier.goToOrderTab(status),
                  borderRadius: borderRadius12,
                  child: Card(
                    shape: roundedRectangleBorder12,
                    child: Container(
                      height: 130,
                      width: 130,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: mainSpaceBetween,
                        children: [
                          SvgPicture.asset(
                            status == orderDeliveryDateToday
                                ? 'assets/svgs/time-format.svg'
                                : status.toOrderStatus.imgPath,
                            width: 30,
                            colorFilter:
                                context.theme.primaryColor.toColorFilter,
                          ),
                          Text(
                            status,
                            textAlign: TextAlign.start,
                            style: context.text.titleSmall,
                          ),
                          Builder(builder: (_) {
                            final total = status == orderDeliveryDateToday
                                ? notifier.todayDeliveriableOrders.length
                                : notifier.getCustomOrders(status).length;
                            return RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Total: ',
                                    style: context.text.labelMedium,
                                  ),
                                  TextSpan(
                                    text: '$total',
                                    style: context.text.titleLarge!.copyWith(
                                        color: context.theme.primaryColor),
                                  ),
                                  TextSpan(
                                    text: total > 1 ? ' Pcs' : ' Pc',
                                    style: context.text.labelMedium,
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
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
