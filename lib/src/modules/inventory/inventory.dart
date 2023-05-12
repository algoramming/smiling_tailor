import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '$appName - Inventories',
        textAlign: TextAlign.center,
      ),
    );
  }
}
