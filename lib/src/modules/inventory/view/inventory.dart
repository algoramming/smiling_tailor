import 'package:flutter/material.dart';
import '../add/view/add.inventory.popup.dart';

import 'components/inventory.details.dart';
import 'components/inventory.list.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Row(
          children: [
            Expanded(flex: 3, child: InventoryList()),
            SizedBox(width: 6.0),
            Expanded(flex: 5, child: InventoryDetails()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        tooltip: 'Add Inventory',
        onPressed: () async => await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AddInventoryPopup(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
