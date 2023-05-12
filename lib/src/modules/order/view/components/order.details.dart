import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '$appName - Orders',
        textAlign: TextAlign.center,
      ),
    );
  }
}
