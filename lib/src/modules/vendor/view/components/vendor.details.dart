import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';

class VendorDetails extends StatelessWidget {
  const VendorDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '$appName - Vendors',
        textAlign: TextAlign.center,
      ),
    );
  }
}
