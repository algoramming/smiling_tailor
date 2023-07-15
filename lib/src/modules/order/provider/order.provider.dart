import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/logger/logger_helper.dart';
import '../enum/order.enum.dart';
import '../model/order.dart';

const orderTypeAll = 'All';
const orderDeliveryDateToday = 'Delivery Date Today';

typedef OrderNotifier = AsyncNotifierProvider<OrderProvider, List<PktbsOrder>>;

final orderProvider = OrderNotifier(OrderProvider.new);

class OrderProvider extends AsyncNotifier<List<PktbsOrder>> {
  final searchCntrlr = TextEditingController();
  PktbsOrder? selectedOrder;
  late List<PktbsOrder> _orders;
  String _selectedStatus = orderTypeAll;
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
      if (s.action == 'delete') {
        _orders.removeWhere((e) => e.id == s.record!.toJson()['id']);
      } else {
        await pb
            .collection(orders)
            .getOne(s.record!.toJson()['id'], expand: pktbsOrderExpand)
            .then((order) {
          log.i('Stream After Get Order: $order');
          if (s.action == 'create') {
            _orders.add(PktbsOrder.fromJson(order.toJson()));
          } else if (s.action == 'update') {
            _orders.removeWhere((e) => e.id == order.id);
            _orders.add(PktbsOrder.fromJson(order.toJson()));
          }
        });
      }
      ref.notifyListeners();
    });
  }

  String get selectedStatus => _selectedStatus;

  void changeStatus(String? status) {
    _selectedStatus = status ?? orderTypeAll;
    ref.notifyListeners();
  }

  List<PktbsOrder> get orderList {
    _orders.sort((a, b) => b.created.toLocal().compareTo(a.created.toLocal()));
    final vs = _selectedStatus == orderTypeAll
        ? _orders
        : _selectedStatus == orderDeliveryDateToday
            ? _orders.where((e) => e.deliveryTime.isToday).toList()
            : _orders
                .where((e) => e.status == _selectedStatus.toOrderStatus)
                .toList();
    return vs
        .where((e) =>
            e.id.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.customerName
                .toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ||
            e.customerPhone
                .toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ||
            e.creator.id
                .toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ||
            (e.updator?.id.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ??
                false) ||
            (e.tailorEmployee?.id
                    .toLowerCase()
                    .contains(searchCntrlr.text.toLowerCase()) ??
                false) ||
            (e.tailorNote?.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ??
                false) ||
            (e.inventory?.id.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ??
                false) ||
            (e.inventory?.title.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ??
                false) ||
            (e.inventory?.description
                    ?.toLowerCase()
                    .contains(searchCntrlr.text.toLowerCase()) ??
                false) ||
            (e.inventoryNote?.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ??
                false) ||
            (e.deliveryEmployee?.id
                    .toLowerCase()
                    .contains(searchCntrlr.text.toLowerCase()) ??
                false) ||
            (e.deliveryNote?.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ??
                false) ||
            (e.deliveryAddress?.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ??
                false) ||
            (e.customerEmail?.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ??
                false) ||
            (e.customerAddress?.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ?? false) ||
            (e.description?.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ?? false))
        .toList();
  }

  void selectOrder(PktbsOrder order) {
    selectedOrder = order;
    ref.notifyListeners();
  }
}
