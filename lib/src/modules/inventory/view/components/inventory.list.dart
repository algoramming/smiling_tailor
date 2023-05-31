import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/constants.dart';
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
                        leading: Container(
                          height: 45.0,
                          width: 45.0,
                          padding: const EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: context.theme.primaryColor, width: 1.3),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius45,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SvgPicture.asset(
                                'assets/svgs/inventory.svg',
                                fit: BoxFit.cover,
                                colorFilter:
                                    context.theme.primaryColor.toColorFilter,
                              ),
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
