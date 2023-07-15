import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/extensions/extensions.dart';
import '../../order/model/order.dart';
import '../../order/provider/order.provider.dart';

typedef GetCustomersNotifier
    = AsyncNotifierProvider<GetCustomersProvider, void>;

final getCustomersProvider = GetCustomersNotifier(GetCustomersProvider.new);

class GetCustomersProvider extends AsyncNotifier {
  late List<PktbsOrder> _orders;
  int _radioOption = 0;
  final preffixController = TextEditingController();
  final suffixController = TextEditingController();
  final joinController = TextEditingController(text: ',\n');
  @override
  FutureOr build() async {
    ref.watch(orderProvider);
    _orders = [];
    _orders = await ref.watch(orderProvider.future);
  }

  int get radioOption => _radioOption; // 0 for phone, 1 for email

  void changeRadioOption() {
    _radioOption = _radioOption == 0 ? 1 : 0;
    ref.notifyListeners();
  }

  refresh() => ref.notifyListeners();

  List<String> get contentList => _radioOption == 0
      ? _orders.map((e) => e.customerPhone).toList().toSet().toList()
      : _orders
          .where((e) => e.customerEmail.isNotNullOrEmpty)
          .map((e) => e.customerEmail!)
          .toList()
          .toSet()
          .toList();

  String get content {
    final prefix = preffixController.text;
    final suffix = suffixController.text;
    final join = joinController.text;

    final modifiedList =
        contentList.map((item) => '$prefix$item$suffix').toList();
    return modifiedList.join(join);
  }
}
