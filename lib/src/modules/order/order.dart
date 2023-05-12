import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

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
