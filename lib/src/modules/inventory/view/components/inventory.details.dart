import 'package:flutter/material.dart';

import '../../../../config/constants.dart';

class InventoryDetails extends StatelessWidget {
  const InventoryDetails({super.key});

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
