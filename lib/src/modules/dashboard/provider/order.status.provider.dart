import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/extensions/extensions.dart';
import '../../home/enum/home.enum.dart';
import '../../home/provider/home.provider.dart';
import '../../order/enum/order.enum.dart';
import '../../order/model/order.dart';
import '../../order/provider/order.provider.dart';

typedef OrderStatusNotifier = AsyncNotifierProvider<OrderStatusProvider, void>;

final orderStatusProvider = OrderStatusNotifier(OrderStatusProvider.new);

class OrderStatusProvider extends AsyncNotifier {
  late List<PktbsOrder> _orders;
  int _summaryRadio = 0;
  @override
  FutureOr build() async {
    ref.watch(orderProvider);
    _orders = [];
    _orders = await ref.watch(orderProvider.future);
  }

  int get summaryRadio => _summaryRadio;

  void changeSummaryRadio() {
    _summaryRadio = _summaryRadio == 0 ? 1 : 0;
    ref.notifyListeners();
  }

  List<PktbsOrder> get todayDeliveriableOrders => _orders
      .where((e) =>
          e.deliveryTime.isToday &&
          (e.status.isNotCompleted || e.status.isNotCompleted))
      .toList();

  List<PktbsOrder> get rawOrders => _orders;

  List<PktbsOrder> get orders => _summaryRadio == 0
      ? _orders
      : _orders.where((e) => e.created.isToday).toList();

  List<PktbsOrder> getCustomOrders(String status) =>
      orders.where((e) => e.status == status.toOrderStatus).toList();

  void goToOrderTab(String status) {
    ref.read(homeProvider.notifier).changeDrawer(null, KDrawer.order);
    ref.read(orderProvider.notifier).changeStatus(status);
  }
}
