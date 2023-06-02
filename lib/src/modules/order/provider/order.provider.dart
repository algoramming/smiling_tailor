import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/order/model/order.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../utils/logger/logger_helper.dart';

typedef OrderNotifier = AsyncNotifierProvider<OrderProvider, List<PktbsOrder>>;

final orderProvider = OrderNotifier(OrderProvider.new);

class OrderProvider extends AsyncNotifier<List<PktbsOrder>> {
  final searchCntrlr = TextEditingController();
  PktbsOrder? selectedOrder;
  late List<PktbsOrder> _orders;
  @override
  FutureOr<List<PktbsOrder>> build() async {
    _orders = [];
    _listener();
    _stream();
    _orders = await pb
        .collection(orders)
        .getFullList(expand: pktbsOrderExpand)
        .then((v) {
      log.i('Orders: $v');
      return v.map((e) => PktbsOrder.fromJson(e.toJson())).toList();
    });

    return _orders;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  _stream() {
    // Implement Stream needs pocketbase update to add filter and expand options then the autodispose had to remove
    pb.collection(orders).subscribe('*', (s) async {
      log.i('Stream $s');
      await pb
          .collection(orders)
          .getOne(
            s.record!.toJson()['id'],
            expand: pktbsOrderExpand,
          )
          .then((order) {
        log.i('Stream After Get Order: $order');
        if (s.action == 'create') {
          _orders.add(PktbsOrder.fromJson(order.toJson()));
        } else if (s.action == 'update') {
          _orders.removeWhere((e) => e.id == order.id);
          _orders.add(PktbsOrder.fromJson(order.toJson()));
        } else if (s.action == 'delete') {
          _orders.removeWhere((e) => e.id == order.id);
        }
        ref.notifyListeners();
      });
    });
  }

  List<PktbsOrder> get orderList {
    _orders.sort((a, b) => b.created.toLocal().compareTo(a.created.toLocal()));
    final vs = _orders;
    return vs
        .where((e) =>
            e.customerName
                .toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ||
            e.customerPhone
                .toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ||
            e.id.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            (e.customerEmail
                    ?.toLowerCase()
                    .contains(searchCntrlr.text.toLowerCase()) ??
                false) ||
            (e.customerAddress
                    ?.toLowerCase()
                    .contains(searchCntrlr.text.toLowerCase()) ??
                false))
        .toList();
  }

  void selectOrder(PktbsOrder order) {
    selectedOrder = order;
    ref.notifyListeners();
  }
}
