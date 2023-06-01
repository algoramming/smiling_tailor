import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../provider/inventory.provider.dart';

class InventoryList extends ConsumerWidget {
  const InventoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(inventoryProvider);
    final notifier = ref.watch(inventoryProvider.notifier);
    return Column(
      children: [
        TextFormField(
          controller: notifier.searchCntrlr,
          decoration: const InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        Flexible(
          child: notifier.inventoryList.isEmpty
              ? const Center(child: Text('No inventory found!'))
              : ListView.builder(
                  itemCount: notifier.inventoryList.length,
                  itemBuilder: (_, idx) {
                    final inventory = notifier.inventoryList[idx];
                    return Card(
                      child: KListTile(
                        selected: notifier.selectedInventory == inventory,
                        onTap: () => notifier.selectInventory(inventory),
                        leading: AnimatedWidgetShower(
                          size: 30.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(
                              'assets/svgs/inventory.svg',
                              colorFilter:
                                  context.theme.primaryColor.toColorFilter,
                              semanticsLabel: 'Inventory',
                            ),
                          ),
                        ),
                        title: Text(inventory.title),
                        subtitle: Text(inventory.description ?? ''),
                        trailing: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    );
                  }),
        ),
      ],
    );
  }
}
