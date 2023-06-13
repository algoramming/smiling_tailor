import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/constants.dart';
import '../../../../db/isar.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/clipboard_data/clipboard_data.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../../utils/logger/logger_helper.dart';
import '../../../settings/model/settings.model.dart';
import '../../../transaction/enum/trx.type.dart';
import '../../../transaction/model/transaction.dart';
import '../../add/view/add.trx.vendor.popup.dart';
import '../../add/view/add.vendor.popup.dart';
import '../../provider/vendor.provider.dart';
import '../../provider/vendor.trxs.provider.dart';

class VendorDetails extends ConsumerWidget {
  const VendorDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(vendorProvider);
    final notifier = ref.watch(vendorProvider.notifier);
    return notifier.selectedVendor == null
        ? const Center(
            child: Text(
              'No Vendor Selected!\n Please select a vendor see full information.',
              textAlign: TextAlign.center,
            ),
          )
        : Column(
            children: [
              Row(
                mainAxisAlignment: mainEnd,
                children: [
                  Consumer(builder: (_, ref, __) {
                    ref.watch(vendorTrxsProvider(notifier.selectedVendor!));
                    final noti = ref.watch(
                        vendorTrxsProvider(notifier.selectedVendor!).notifier);
                    return Expanded(
                      child: TextFormField(
                        controller: noti.searchCntrlr,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon:
                              ClearPreffixIcon(() => noti.searchCntrlr.clear()),
                          suffixIcon: PasteSuffixIcon(() async =>
                              noti.searchCntrlr.text = await getCliboardData()),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 6.0),
                  OutlinedButton.icon(
                    onPressed: () async => await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) =>
                          AddTrxVendorPopup(notifier.selectedVendor!),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('Transaction'),
                  ),
                  const SizedBox(width: 6.0),
                  OutlinedButton.icon(
                    onPressed: () async => await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const AddVendorPopup(),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('Vendor'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _TrxTable(notifier),
            ],
          );
  }
}

class _TrxTable extends StatelessWidget {
  const _TrxTable(this.notifier);

  final VendorProvider notifier;

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
                tabs: const [Tab(text: 'Financials'), Tab(text: 'Inventories')],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _FinancialsTab(notifier),
              _InventoriesTab(notifier),
            ],
          ),
        ),
      ),
    );
  }
}

class _FinancialsTab extends StatelessWidget {
  const _FinancialsTab(this.notifier);

  final VendorProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TrxList(notifier, condition: (t) => t.isGoods == false),
        const SizedBox(height: 10),
        _TotalSummaryFinanacials(notifier, (t) => t.isGoods == false),
      ],
    );
  }
}

class _InventoriesTab extends StatelessWidget {
  const _InventoriesTab(this.notifier);

  final VendorProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TrxList(notifier, condition: (t) => t.isGoods == true),
        const SizedBox(height: 10),
        _TotalSummaryInVentory(notifier, (t) => t.isGoods == true),
      ],
    );
  }
}

class _TrxList extends ConsumerWidget {
  const _TrxList(this.notifier, {required this.condition});

  final VendorProvider notifier;
  final bool Function(PktbsTrx trx) condition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(vendorTrxsProvider(notifier.selectedVendor!));
    final noti =
        ref.watch(vendorTrxsProvider(notifier.selectedVendor!).notifier);
    final trxs = noti.trxList.where(condition).toList();
    return Expanded(
      child: trxs.isEmpty
          ? const Center(
              child: Text('No Transaction Found!', textAlign: TextAlign.center))
          : SlidableAutoCloseBehavior(
            child: ListView.builder(
                itemCount: trxs.length,
                itemBuilder: (_, i) {
                  final trx = trxs[i];
                  final kColor = trx.trxType.isCredit ? Colors.red : Colors.green;
                  return Card(
                    child: KListTile(
                      key: ValueKey(trx.id),
                      swipeLeft: () => log.i('swipe left'),
                      swipeRight: () => log.i('swipe right'),
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
                                    await copyToClipboard(context, trx.fromId),
                            ),
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
                                child: RotatedBox(
                                  quarterTurns: trx.trxType.isDebit ? 0 : 1,
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
                                    await copyToClipboard(context, trx.toId),
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
                                  .copyWith(fontWeight: FontWeight.normal),
                            ),
                        ],
                      ),
                      trailing: TweenAnimationBuilder(
                        curve: Curves.easeOut,
                        duration: kAnimationDuration(0.5),
                        tween: Tween<double>(begin: 0, end: trx.amount),
                        builder: (_, double x, __) {
                          return Tooltip(
                            message: trx.isGoods ? '' : x.formattedFloat,
                            child: Text(
                              !trx.isGoods
                                  ? x.formattedCompat
                                  : '${x.toInt()} ${trx.unit?.symbol ?? '??'}',
                              style: context.text.labelLarge!
                                  .copyWith(color: kColor),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
          ),
    );
  }
}

class _TotalSummaryFinanacials extends ConsumerWidget {
  const _TotalSummaryFinanacials(this.notifier, this.condition);

  final VendorProvider notifier;
  final bool Function(PktbsTrx trx) condition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(vendorTrxsProvider(notifier.selectedVendor!));
    final noti =
        ref.watch(vendorTrxsProvider(notifier.selectedVendor!).notifier);
    final trxs = noti.rawTrxs.where(condition).toList();
    final total = noti.inventories.fold<double>(0.0, (p, c) => p + c.amount);
    final adjusted = trxs.isEmpty
        ? 0.0
        : trxs.fold<double>(
            0.0,
            (p, c) =>
                p +
                (c.trxType.isCredit ? c.amount : 0.0) -
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
          'Total due till now ${appSettings.getDateTimeFormat.format(DateTime.now())}',
        ),
        subtitle: Text(
          'Total Purchase: ${total.formattedFloat} and Adjusted: ${adjusted.formattedFloat}',
        ),
        trailing: TweenAnimationBuilder(
          curve: Curves.easeOut,
          duration: kAnimationDuration(0.5),
          tween: Tween<double>(begin: 0, end: due),
          builder: (_, double x, __) {
            return Tooltip(
              message: x.formattedFloat,
              child: Text(
                x.formattedCompat,
                style: context.text.labelLarge!.copyWith(color: kColor),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TotalSummaryInVentory extends ConsumerWidget {
  const _TotalSummaryInVentory(this.notifier, this.condition);

  final VendorProvider notifier;
  final bool Function(PktbsTrx trx) condition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(vendorTrxsProvider(notifier.selectedVendor!));
    final noti =
        ref.watch(vendorTrxsProvider(notifier.selectedVendor!).notifier);
    final trxs = noti.rawTrxs.where(condition).toList();
    final total = noti.inventories.fold<double>(0.0, (p, c) => p + c.quantity);
    final sold = trxs.fold<double>(
        0.0, (p, c) => p + (c.trxType.isDebit ? c.amount : 0.0));
    final returned = trxs.fold<double>(
        0.0, (p, c) => p + (c.trxType.isCredit ? c.amount : 0.0));
    final due = sold - returned;
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
          'Total Purchase: ${total.toInt()} pc, Return: ${returned.toInt()} pc and Total Order Placed: ${noti.inventories.length} times',
        ),
        trailing: TweenAnimationBuilder(
          curve: Curves.easeOut,
          duration: kAnimationDuration(0.5),
          tween: Tween<double>(begin: 0, end: due),
          builder: (_, double x, __) {
            return Text(
              '${x.toInt()} pc',
              style: context.text.labelLarge!.copyWith(color: kColor),
            );
          },
        ),
      ),
    );
  }
}
