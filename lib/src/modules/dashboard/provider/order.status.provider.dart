import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/order/provider/order.provider.dart';

import '../../home/enum/home.enum.dart';
import '../../home/provider/home.provider.dart';
import '../../order/enum/order.enum.dart';
import '../../order/model/order.dart';

typedef OrderStatusNotifier = AsyncNotifierProvider<OrderStatusProvider, void>;

final orderStatusProvider = OrderStatusNotifier(OrderStatusProvider.new);

class OrderStatusProvider extends AsyncNotifier {
  late List<PktbsOrder> _orders;
  @override
  FutureOr build() async {
    ref.watch(orderProvider);
    _orders = [];
    _orders = await ref.watch(orderProvider.future);
  }

  List<PktbsOrder> get orders => _orders;

  List<PktbsOrder> getCustomOrders(OrderStatus status) =>
      _orders.where((e) => e.status == status).toList();

  void goToOrderTab(OrderStatus status) {
    ref.read(homeProvider.notifier).changeDrawer(null, KDrawer.order);
    ref.read(orderProvider.notifier).changeStatus(status.label);
  }
}
