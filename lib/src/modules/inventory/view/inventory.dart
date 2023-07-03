import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/authentication/model/user.dart';

import '../../../shared/loading_widget/loading_widget.dart';
import '../../../shared/page_not_found/page_not_found.dart';
import '../../../utils/themes/themes.dart';
import '../../../utils/transations/big.to.small.dart';
import '../../profile/provider/profile.provider.dart';
import '../add/view/add.inventory.popup.dart';
import '../provider/inventory.provider.dart';
import 'components/inventory.details.dart';
import 'components/inventory.list.dart';

class InventoryView extends ConsumerWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileProvider);
    if (user == null) return const LoadingWidget();
    if (user.isDispose || user.isOperator) return const AccesDeniedPage();
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
      floatingActionButton: Consumer(
        builder: (_, ref, __) {
          ref.watch(inventoryProvider);
          final notifier =
              ref.watch(inventoryProvider.notifier).selectedInventory;
          return BigToSmallTransition(
            child: notifier != null
                ? const SizedBox.shrink()
                : FloatingActionButton.small(
                    tooltip: 'Add Inventory',
                    onPressed: () async => await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => const AddInventoryPopup(),
                    ),
                    child: const Icon(Icons.add, color: white),
                  ),
          );
        },
      ),
    );
  }
}
