import 'package:flutter/material.dart';
import 'package:smiling_tailor/src/modules/vendor/add/view/add.vendor.popup.dart';

import 'components/vendor.details.dart';
import 'components/vendor.list.dart';

class VendorView extends StatelessWidget {
  const VendorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Row(
          children: [
            Expanded(flex: 3, child: VendorList()),
            SizedBox(width: 6.0),
            Expanded(flex: 5, child: VendorDetails()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        tooltip: 'Add Vendor',
        onPressed: () async => await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AddVendorPopup(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
