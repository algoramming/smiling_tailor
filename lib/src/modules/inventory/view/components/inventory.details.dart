import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/constants.dart';
import '../../../../db/db.dart';
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
import '../../../settings/model/settings.model.dart';
import '../../../transaction/api/trx.api.dart';
import '../../../transaction/enum/trx.type.dart';
import '../../../transaction/model/transaction.dart';
import '../../add/view/add.inventory.popup.dart';
import '../../provider/inventory.provider.dart';
import '../../provider/inventory.trxs.provider.dart';

class InventoryDetails extends ConsumerWidget {
  const InventoryDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(inventoryProvider);
    final notifier = ref.watch(inventoryProvider.notifier);
    return FadeSwitcherTransition(
      child: notifier.selectedInventory == null
          ? const Center(
              child: Text(
                'No Inventory Selected!\n Please select a inventory see full information.',
                textAlign: TextAlign.center,
              ),
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: mainEnd,
                  children: [
                    Consumer(builder: (_, ref, __) {
                      ref.watch(
                          inventoryTrxsProvider(notifier.selectedInventory!));
                      final noti = ref.watch(
                          inventoryTrxsProvider(notifier.selectedInventory!)
                              .notifier);
                      return Expanded(
                        child: TextFormField(
                          controller: noti.searchCntrlr,
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            prefixIcon: ClearPrefixIcon(
                                () => noti.searchCntrlr.clear()),
                            suffixIcon: PasteSuffixIcon(() async => noti
                                .searchCntrlr.text = await getCliboardData()),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(width: 6.0),
                    OutlinedButton.icon(
                      onPressed: () async => await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => const AddInventoryPopup(),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('Inventory'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _TrxTable(notifier),
              ],
            ),
    );
  }
}

class _TrxTable extends StatelessWidget {
  const _TrxTable(this.notifier);

  final InventoryProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (_, __) => [
            SliverToBoxAdapter(
              child: TabBar(
                splashBorderRadius: borderRadius15,
                dividerColor: Colors.transparent,
                labelStyle: context.theme.textTheme.labelLarge,
                tabs: const [
                  // Tab(text: 'Financials'),
                  Tab(text: 'Inventories'),
                  Tab(text: 'Orders'),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              // _FinancialsTab(notifier),
              _InventoriesTab(notifier),
              _OrdersTab(notifier),
            ],
          ),
        ),
      ),
    );
  }
}

// class _FinancialsTab extends StatelessWidget {
//   const _FinancialsTab(this.notifier);

//   final InventoryProvider notifier;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _TrxList(notifier,
//             condition: (t) =>
//                 t.isGoods == false &&
//                 t.fromType.isNotOrder &&
//                 t.toType.isNotOrder),
//         const SizedBox(height: 10),
//         _TotalSummaryFinancials(
//           notifier,
//           (t) =>
//               t.isGoods == false &&
//               t.fromType.isNotOrder &&
//               t.toType.isNotOrder,
//         ),
//       ],
//     );
//   }
// }

class _InventoriesTab extends StatelessWidget {
  const _InventoriesTab(this.notifier);

  final InventoryProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TrxList(
          notifier,
          condition: (t) =>
              t.isGoods == true && (t.fromType.isOrder || t.toType.isOrder),
        ),
        const SizedBox(height: 10),
        _TotalSummaryInventories(
          notifier,
          (t) => t.isGoods == true && (t.fromType.isOrder || t.toType.isOrder),
        ),
      ],
    );
  }
}

class _OrdersTab extends StatelessWidget {
  const _OrdersTab(this.notifier);

  final InventoryProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TrxList(
          notifier,
          condition: (t) =>
              t.isGoods == false && (t.fromType.isOrder || t.toType.isOrder),
        ),
        const SizedBox(height: 10),
        _TotalSummaryOrders(
          notifier,
          (t) => t.isGoods == false && (t.fromType.isOrder || t.toType.isOrder),
        ),
      ],
    );
  }
}

class _TrxList extends ConsumerWidget {
  const _TrxList(this.notifier, {required this.condition});

  final InventoryProvider notifier;
  final bool Function(PktbsTrx trx) condition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ref.watch(inventoryTrxsProvider(notifier.selectedInventory!)).when(
            loading: () => const LoadingWidget(withScaffold: false),
            error: (err, _) => KErrorWidget(error: err),
            data: (_) {
              final noti = ref.watch(
                  inventoryTrxsProvider(notifier.selectedInventory!).notifier);
              final trxs = noti.trxList.where(condition).toList();
              return trxs.isEmpty
                  ? const KDataNotFound(msg: 'No Transaction Found!')
                  : Column(
                      children: [
                        if (trxs.isNotEmpty &&
                            trxs.any((e) => !e.isSystemGenerated))
                          const SwipeIndicator(),
                        Expanded(
                          child: SlidableAutoCloseBehavior(
                            child: ListView.builder(
                              itemCount: trxs.length,
                              itemBuilder: (_, i) {
                                final trx = trxs[i];
                                final kColor = trx.trxType.isCredit
                                    ? Colors.red
                                    : Colors.green;
                                return Card(
                                  child: KListTile(
                                    key: ValueKey(trx.id),
                                    isSystemGenerated: trx.isSystemGenerated,
                                    canEdit: false,
                                    onDeleteTap: () async =>
                                        await trxDeletePopup(context, trx),
                                    onLongPress: () async =>
                                        await copyToClipboard(context, trx.id),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 5.0),
                                    leading: AnimatedWidgetShower(
                                      padding: 3.0,
                                      size: 35.0,
                                      child: trx.modifiers,
                                    ),
                                    title: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: trx.fromName,
                                            style: context.text.titleSmall,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async =>
                                                  await copyToClipboard(
                                                      context, trx.fromId),
                                          ),
                                          WidgetSpan(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6.0),
                                              child: RotatedBox(
                                                quarterTurns:
                                                    trx.trxType.isDebit ? 0 : 1,
                                                child: Icon(
                                                  Icons.arrow_outward_rounded,
                                                  size: 16,
                                                  color: kColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextSpan(
                                            text: trx.toName,
                                            style: context.text.titleSmall,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async =>
                                                  await copyToClipboard(
                                                      context, trx.toId),
                                          ),
                                        ],
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: crossStart,
                                      children: [
                                        Text(
                                          trx.createdDate,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: context.text.labelMedium,
                                        ),
                                        if (trx.description != null)
                                          Text(
                                            trx.description!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: context.text.labelSmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal),
                                          ),
                                      ],
                                    ),
                                    trailing: TweenAnimationBuilder(
                                      curve: Curves.easeOut,
                                      duration: kAnimationDuration(0.5),
                                      tween: Tween<double>(
                                          begin: 0, end: trx.amount),
                                      builder: (_, double x, __) {
                                        return Tooltip(
                                          message: trx.isGoods
                                              ? ''
                                              : x.formattedFloat,
                                          child: Text(
                                            !trx.isGoods
                                                ? x.formattedCompat
                                                : '${x.toInt()} ${trx.unit?.symbol ?? '??'}',
                                            style: context.text.labelLarge!
                                                .copyWith(
                                              color: kColor,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
            },
          ),
    );
  }
}

// class _TotalSummaryFinancials extends ConsumerWidget {
//   const _TotalSummaryFinancials(this.notifier, this.condition);

//   final InventoryProvider notifier;
//   final bool Function(PktbsTrx trx) condition;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.watch(inventoryTrxsProvider(notifier.selectedInventory!));
//     final noti =
//         ref.watch(inventoryTrxsProvider(notifier.selectedInventory!).notifier);
//     final trxs = noti.rawTrxs.where(condition).toList();
//     final total = notifier.selectedInventory?.amount.toString().toDouble ?? 0.0;
//     final adjusted = trxs.isEmpty
//         ? 0.0
//         : trxs.fold<double>(
//             0.0,
//             (p, c) =>
//                 p +
//                 (c.trxType.isCredit ? c.amount : 0.0) -
//                 (c.trxType.isDebit ? c.amount : 0.0));
//     final due = total - adjusted;
//     final kColor = due.isNegative ? Colors.green : Colors.red;
//     return Card(
//       color: context.theme.dividerColor.withOpacity(0.2),
//       child: ListTile(
//         leading: AnimatedWidgetShower(
//           padding: 3.0,
//           size: 35.0,
//           child: Card(
//             color: kColor.withOpacity(0.2),
//             shape: roundedRectangleBorder10,
//             child: SvgPicture.asset(
//               'assets/svgs/performance-overlay.svg',
//               colorFilter: kColor.toColorFilter,
//             ),
//           ),
//         ),
//         title: Text(
//           'Total due till now ${appSettings.getDateTimeFormat.format(DateTime.now())}',
//         ),
//         subtitle: Text(
//           'Total Purchase: ${total.formattedFloat} and Given: ${adjusted.formattedFloat}',
//         ),
//         trailing: TweenAnimationBuilder(
//           curve: Curves.easeOut,
//           duration: kAnimationDuration(0.5),
//           tween: Tween<double>(begin: 0, end: due),
//           builder: (_, double x, __) {
//             return Tooltip(
//               message: x.formattedFloat,
//               child: Text(
//                 x.formattedCompat,
//                 style: context.text.labelLarge!.copyWith(
//                   color: kColor,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class _TotalSummaryInventories extends ConsumerWidget {
  const _TotalSummaryInventories(this.notifier, this.condition);

  final InventoryProvider notifier;
  final bool Function(PktbsTrx trx) condition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(inventoryTrxsProvider(notifier.selectedInventory!));
    final noti =
        ref.watch(inventoryTrxsProvider(notifier.selectedInventory!).notifier);
    final trxs = noti.rawTrxs.where(condition).toList();
    final total =
        notifier.selectedInventory?.quantity.toString().toDouble ?? 0.0;
    final adjusted = trxs.isEmpty
        ? 0.0
        : trxs.fold<double>(
            0.0,
            (p, c) =>
                p +
                (c.trxType.isCredit ? c.amount : 0.0) -
                (c.trxType.isDebit ? c.amount : 0.0));
    final due = total - adjusted;
    final kColor = due.isNegative ? Colors.red : Colors.green;
    return Card(
      color: context.theme.dividerColor.withOpacity(0.2),
      child: ListTile(
        leading: AnimatedWidgetShower(
          padding: 3.0,
          size: 35.0,
          child: Card(
            color: kColor.withOpacity(0.2),
            shape: roundedRectangleBorder10,
            child: SvgPicture.asset(
              'assets/svgs/performance-overlay.svg',
              colorFilter: kColor.toColorFilter,
            ),
          ),
        ),
        title: Text(
          'Total summary till now ${appSettings.getDateTimeFormat.format(DateTime.now())}',
        ),
        subtitle: Text(
          'Total Purchase: ${total.toInt()} ${notifier.selectedInventory?.unit.symbol ?? '??'} and Adjusted: ${adjusted.toInt()} ${notifier.selectedInventory?.unit.symbol ?? '??'}',
        ),
        trailing: TweenAnimationBuilder(
          curve: Curves.easeOut,
          duration: kAnimationDuration(0.5),
          tween: Tween<double>(begin: 0, end: due),
          builder: (_, double x, __) {
            return Text(
              '${x.toInt()} ${notifier.selectedInventory?.unit.symbol ?? '??'}',
              style: context.text.labelLarge!.copyWith(
                color: kColor,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TotalSummaryOrders extends ConsumerWidget {
  const _TotalSummaryOrders(this.notifier, this.condition);

  final InventoryProvider notifier;
  final bool Function(PktbsTrx trx) condition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(inventoryTrxsProvider(notifier.selectedInventory!));
    final noti =
        ref.watch(inventoryTrxsProvider(notifier.selectedInventory!).notifier);
    final trxs = noti.rawTrxs.where(condition).toList();
    final total = notifier.selectedInventory?.amount.toString().toDouble ?? 0.0;
    final adjusted = trxs.isEmpty
        ? 0.0
        : trxs.fold<double>(
            0.0,
            (p, c) =>
                p -
                (c.trxType.isCredit ? c.amount : 0.0) +
                (c.trxType.isDebit ? c.amount : 0.0));
    final due = total - adjusted;
    final kColor = due.isNegative ? Colors.green : Colors.red;
    return Card(
      color: context.theme.dividerColor.withOpacity(0.2),
      child: ListTile(
        leading: AnimatedWidgetShower(
          padding: 3.0,
          size: 35.0,
          child: Card(
            color: kColor.withOpacity(0.2),
            shape: roundedRectangleBorder10,
            child: SvgPicture.asset(
              'assets/svgs/performance-overlay.svg',
              colorFilter: kColor.toColorFilter,
            ),
          ),
        ),
        title: Text(
          'Total summary till now ${appSettings.getDateTimeFormat.format(DateTime.now())}',
        ),
        subtitle: Text(
          'Purchase Price: ${total.formattedFloat} and Total Sold: ${adjusted.formattedFloat}',
        ),
        trailing: TweenAnimationBuilder(
          curve: Curves.easeOut,
          duration: kAnimationDuration(0.5),
          tween: Tween<double>(begin: 0, end: due),
          builder: (_, double x, __) {
            return Tooltip(
              message: x.formattedFloat,
              child: Text(
                due.isNegative
                    ? 'Profit: ${x.mod.formattedCompat}'
                    : x.formattedCompat,
                style: context.text.labelLarge!.copyWith(
                  color: kColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
