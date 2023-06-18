import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/constants.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/clipboard_data/clipboard_data.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../shared/page_not_found/page_not_found.dart';
import '../../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../../utils/logger/logger_helper.dart';
import '../../../../utils/themes/themes.dart';
import '../../add/view/order.slip.download.popup.dart';
import '../../provider/order.provider.dart';

class OrderList extends ConsumerWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(orderProvider);
    final notifier = ref.watch(orderProvider.notifier);
    return Column(
      children: [
        TextFormField(
          controller: notifier.searchCntrlr,
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: ClearPreffixIcon(() => notifier.searchCntrlr.clear()),
            suffixIcon: PasteSuffixIcon(() async =>
                notifier.searchCntrlr.text = await getCliboardData()),
          ),
        ),
        Flexible(
          child: notifier.orderList.isEmpty
              ? const KDataNotFound(msg: 'No Order Found!')
              : SlidableAutoCloseBehavior(
                  child: ListView.builder(
                    itemCount: notifier.orderList.length,
                    itemBuilder: (_, idx) {
                      final order = notifier.orderList[idx];
                      return Card(
                        child: KListTile(
                          key: ValueKey(order.id),
                          onEditTap: () => log.i('On Edit Tap'),
                          onDeleteTap: () => log.i('On Delete Tap'),
                          slidableAction: Theme(
                            data: context.theme.copyWith(
                              iconTheme:
                                  context.theme.iconTheme.copyWith(size: 20.0),
                            ),
                            child: SlidableAction(
                              borderRadius: borderRadius15,
                              onPressed: (_) async =>
                                  await showOrderSlipDownloadPopup(
                                      context, order),
                              backgroundColor: context.theme.primaryColor,
                              foregroundColor: white,
                              icon: Icons.print_outlined,
                              label: 'Print',
                              padding: EdgeInsets.zero,
                              autoClose: true,
                            ),
                          ),
                          selected: notifier.selectedOrder == order,
                          onTap: () => notifier.selectOrder(order),
                          onLongPress: () async =>
                              await copyToClipboard(context, order.id),
                          leading: AnimatedWidgetShower(
                            size: 30.0,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SvgPicture.asset(
                                'assets/svgs/order.svg',
                                colorFilter:
                                    context.theme.primaryColor.toColorFilter,
                                semanticsLabel: 'Inventory',
                              ),
                            ),
                          ),
                          title: Text(order.customerName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: context.text.titleSmall,
                          ),
                          subtitle: Text(order.customerPhone,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: context.text.labelSmall!
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          trailing:
                              const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
