import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../provider/order.provider.dart';

import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';

class OrderList extends ConsumerWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(orderProvider);
    final notifier = ref.watch(orderProvider.notifier);
    return Column(
      children: [
        TextFormField(
          controller: notifier.searchCntrlr,
          decoration: const InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        Flexible(
          child: notifier.orderList.isEmpty
              ? const Center(child: Text('No order found!'))
              : ListView.builder(
                  itemCount: notifier.orderList.length,
                  itemBuilder: (_, idx) {
                    final order = notifier.orderList[idx];
                    return Card(
                      child: KListTile(
                        selected: notifier.selectedOrder == order,
                        onTap: () => notifier.selectOrder(order),
                        leading: AnimatedWidgetShower(
                          size: 30.0,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SvgPicture.asset(
                              'assets/svgs/order.svg',
                              colorFilter:
                                  context.theme.primaryColor.toColorFilter,
                              semanticsLabel: 'Inventory',
                            ),
                          ),
                        ),
                        title: Text(order.customerName),
                        subtitle: Text(order.customerPhone),
                        trailing: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
