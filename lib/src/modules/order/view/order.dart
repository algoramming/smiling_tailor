import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/themes/themes.dart';
import '../../../utils/transations/big.to.small.dart';
import '../add/view/add.order.popup.dart';
import '../provider/order.provider.dart';
import 'components/order.details.dart';
import 'components/order.list.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Row(
          children: [
            Expanded(flex: 3, child: OrderList()),
            SizedBox(width: 6.0),
            Expanded(flex: 5, child: OrderDetails()),
          ],
        ),
      ),
      floatingActionButton: Consumer(
        builder: (_, ref, __) {
          ref.watch(orderProvider);
          final notifier = ref.watch(orderProvider.notifier).selectedOrder;
          return BigToSmallTransition(
            child: notifier != null
                ? const SizedBox.shrink()
                : FloatingActionButton.small(
                    tooltip: 'Add Order',
                    onPressed: () async => await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => const AddOrderPopup(),
                    ),
                    child: const Icon(Icons.add, color: white),
                  ),
          );
        },
      ),
    );
  }
}
