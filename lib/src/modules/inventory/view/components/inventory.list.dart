import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/constants.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/clipboard_data/clipboard_data.dart';
import '../../../../shared/error_widget/error_widget.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../shared/loading_widget/loading_widget.dart';
import '../../../../shared/page_not_found/page_not_found.dart';
import '../../../../shared/swipe.indicator/swipe.indicator.dart';
import '../../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../../utils/transations/fade.switcher.dart';
import '../../add/view/add.inventory.popup.dart';
import '../../delete/view/delete.inventory.popup.dart';
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
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: ClearPrefixIcon(() => notifier.searchCntrlr.clear()),
            suffixIcon: PasteSuffixIcon(() async =>
                notifier.searchCntrlr.text = await getCliboardData()),
          ),
        ),
        Flexible(
          child: ref.watch(inventoryProvider).when(
              loading: () => const LoadingWidget(withScaffold: false),
              error: (err, _) => KErrorWidget(error: err),
              data: (_) => FadeSwitcherTransition(
                    child: notifier.inventoryList.isEmpty
                        ? const KDataNotFound(msg: 'No Inventory Found!')
                        : Column(
                            children: [
                              const SwipeIndicator(),
                              Flexible(
                                child: SlidableAutoCloseBehavior(
                                  child: ListView.builder(
                                    itemCount: notifier.inventoryList.length,
                                    itemBuilder: (_, idx) {
                                      final inventory =
                                          notifier.inventoryList[idx];
                                      return Card(
                                        child: KListTile(
                                          key: ValueKey(inventory.id),
                                          onEditTap: () async =>
                                              await showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (_) => AddInventoryPopup(
                                              inventory: inventory,
                                            ),
                                          ),
                                          onDeleteTap: () async =>
                                              await showDeleteInventoryPopup(
                                                  context, inventory),
                                          selected:
                                              notifier.selectedInventory ==
                                                  inventory,
                                          onTap: () => notifier
                                              .selectInventory(inventory),
                                          onLongPress: () async =>
                                              await copyToClipboard(
                                                  context, inventory.id),
                                          leading: AnimatedWidgetShower(
                                            size: 30.0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: SvgPicture.asset(
                                                'assets/svgs/inventory.svg',
                                                colorFilter: context.theme
                                                    .primaryColor.toColorFilter,
                                                semanticsLabel: 'Inventory',
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            inventory.title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: context.text.titleSmall,
                                          ),
                                          subtitle: Text(
                                            inventory.description ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: context.text.labelSmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal),
                                          ),
                                          trailing: Column(
                                            crossAxisAlignment: crossEnd,
                                            mainAxisAlignment: mainCenter,
                                            children: [
                                              Text(
                                                inventory
                                                    .amount.formattedCompat,
                                                style: context.text.labelLarge!
                                                    .copyWith(
                                                  color: context
                                                      .theme.primaryColor,
                                                ),
                                              ),
                                              Text(
                                                '${inventory.quantity} ${inventory.unit.symbol}',
                                                style: context.text.bodySmall!
                                                    .copyWith(
                                                  color: context
                                                      .theme.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                  )),
        ),
      ],
    );
  }
}
