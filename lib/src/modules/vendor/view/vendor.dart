import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/transations/big.to.small.dart';
import '../add/view/add.vendor.popup.dart';
import '../provider/vendor.provider.dart';
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
      floatingActionButton: Consumer(
        builder: (_, ref, __) {
          ref.watch(vendorProvider);
          final notifier = ref.watch(vendorProvider.notifier).selectedVendor;
          return BigToSmallTransition(
            child: notifier != null
                ? const SizedBox.shrink()
                : FloatingActionButton.small(
                    tooltip: 'Add Vendor',
                    onPressed: () async => await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => const AddVendorPopup(),
                    ),
                    child: const Icon(Icons.add),
                  ),
          );
        },
      ),
    );
  }
}
