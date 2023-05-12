import 'package:flutter/material.dart';

import 'components/order.details.dart';
import 'components/order.list.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            children: [
              Expanded(flex: 3, child: OrderList()),
              SizedBox(width: 6.0),
              Expanded(flex: 5, child: OrderDetails()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        tooltip: 'Add Order',
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
