import 'package:flutter/material.dart';

import 'components/inventory.details.dart';
import 'components/inventory.list.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            children: [
              Expanded(flex: 3, child: InventoryList()),
              SizedBox(width: 6.0),
              Expanded(flex: 5, child: InventoryDetails()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        tooltip: 'Add Inventory',
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
