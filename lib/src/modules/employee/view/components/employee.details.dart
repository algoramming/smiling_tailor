import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/constants.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/clipboard_data/clipboard_data.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../../utils/logger/logger_helper.dart';
import '../../../transaction/enum/trx.type.dart';
import '../../../transaction/model/transaction.dart';
import '../../add/view/add.employee.popup.dart';
import '../../add/view/add.trx.employee.popup.dart';
import '../../provider/employee.provider.dart';
import '../../provider/employee.trxs.provider.dart';

class EmployeeDetails extends ConsumerWidget {
  const EmployeeDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(employeeProvider);
    final notifier = ref.watch(employeeProvider.notifier);
    return notifier.selectedEmployee == null
        ? const Center(
            child: Text(
              'No Employee Selected!\n Please select an employee see full information.',
              textAlign: TextAlign.center,
            ),
          )
        : Column(
            children: [
              Row(
                mainAxisAlignment: mainEnd,
                children: [
                  Consumer(builder: (_, ref, __) {
                    ref.watch(employeeTrxsProvider(notifier.selectedEmployee!));
                    final noti = ref.watch(
                        employeeTrxsProvider(notifier.selectedEmployee!)
                            .notifier);
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
                      builder: (context) =>
                          AddTrxEmployeePopup(notifier.selectedEmployee!),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('Transaction'),
                  ),
                  const SizedBox(width: 6.0),
                  OutlinedButton.icon(
                    onPressed: () async => await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const AddEmployeePopup(),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('Employee'),
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

  final EmployeeProvider notifier;

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
                tabs: const [Tab(text: 'Financials'), Tab(text: 'Orders')],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _FinancialsTab(notifier),
              _OrdersTab(notifier),
            ],
          ),
        ),
      ),
    );
  }
}

class _FinancialsTab extends StatelessWidget {
  const _FinancialsTab(this.notifier);

  final EmployeeProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TrxList(notifier,
            condition: (t) => t.fromType.isUser || t.toType.isUser),
        const SizedBox(height: 10),
        _TotalSummaryFinancials(
            notifier, (t) => t.fromType.isUser || t.toType.isUser),
      ],
    );
  }
}

class _OrdersTab extends StatelessWidget {
  const _OrdersTab(this.notifier);

  final EmployeeProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TrxList(notifier,
            condition: (t) => t.fromType.isOrder || t.toType.isOrder),
        const SizedBox(height: 10),
        _TotalSummaryOrders(
            notifier, (t) => t.fromType.isOrder || t.toType.isOrder),
      ],
    );
  }
}

class _TrxList extends ConsumerWidget {
  const _TrxList(this.notifier, {required this.condition});

  final EmployeeProvider notifier;
  final bool Function(PktbsTrx trx) condition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(employeeTrxsProvider(notifier.selectedEmployee!));
    final noti =
        ref.watch(employeeTrxsProvider(notifier.selectedEmployee!).notifier);
    final trxs = noti.trxList.where(condition).toList();
    return Expanded(
      child: trxs.isEmpty
          ? const Center(child: Text('No Transaction Found!'))
          : SlidableAutoCloseBehavior(
            child: ListView.builder(
                itemCount: trxs.length,
                itemBuilder: (_, i) {
                  final trx = trxs[i];
                  final kColor = trx.trxType.isCredit ? Colors.red : Colors.green;
                  return Card(
                    child: KListTile(
                      key: ValueKey(trx.id),
                      onEditTap: () => log.i('On Edit Tap'),
                      onDeleteTap: () => log.i('On Delete Tap'),
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
                                    const EdgeInsets.symmetric(horizontal: 3.0),
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
                        builder: (_, double x, __) => Tooltip(
                          message: x.formattedFloat,
                          child: Text(
                            x.formattedCompat,
                            style:
                                context.text.labelLarge!.copyWith(color: kColor),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ),
    );
  }
}

class _TotalSummaryFinancials extends ConsumerWidget {
  const _TotalSummaryFinancials(this.notifier, this.condition);

  final EmployeeProvider notifier;
  final bool Function(PktbsTrx trx) condition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(employeeTrxsProvider(notifier.selectedEmployee!));
    final noti =
        ref.watch(employeeTrxsProvider(notifier.selectedEmployee!).notifier);
    final salary = notifier.selectedEmployee!.salary;
    final trxs = noti.rawTrxs.where(condition).toList();
    final adjusted = trxs.isEmpty
        ? 0.0
        : trxs
            .where((e) =>
                e.created.toLocal().month ==
                (noti.showPrevMonth
                    ? DateTime.now().previousMonth.month
                    : DateTime.now().month))
            .fold<double>(
                0.0,
                (p, c) =>
                    p +
                    (c.trxType.isCredit ? c.amount : 0.0) -
                    (c.trxType.isDebit ? c.amount : 0.0));
    final due = salary - adjusted;
    final kColor = due.isNegative ? Colors.green : Colors.red;
    return Row(
      children: [
        if (!noti.showPrevMonth)
          InkWell(
            borderRadius: borderRadius45,
            onTap: () => noti.toggleShowPrevMonth(),
            child: Container(
              padding: const EdgeInsets.fromLTRB(5.0, 15.0, 0.0, 15.0),
              margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
              child: const Icon(Icons.arrow_back_ios),
            ),
          ),
        Expanded(
          child: Card(
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
                  'Total owe for Month (${(noti.showPrevMonth ? DateTime.now().previousMonth : DateTime.now()).monthName})'),
              subtitle: Text(
                  'Salary: ${salary.formattedFloat} & Taken: ${adjusted.formattedFloat}'),
              trailing: TweenAnimationBuilder(
                curve: Curves.easeOut,
                duration: kAnimationDuration(0.5),
                tween: Tween<double>(begin: 0, end: due),
                builder: (_, double x, __) {
                  return Tooltip(
                    message: x.formattedFloat,
                    child: Text(
                      x.formattedCompat,
                      style: context.text.labelLarge!.copyWith(
                        color: kColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        if (noti.showPrevMonth)
          InkWell(
            borderRadius: borderRadius45,
            onTap: () => noti.toggleShowPrevMonth(),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0.0, 15.0, 5.0, 15.0),
              margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
              child: const Icon(Icons.arrow_forward_ios),
            ),
          ),
      ],
    );
  }
}

class _TotalSummaryOrders extends ConsumerWidget {
  const _TotalSummaryOrders(this.notifier, this.condition);

  final EmployeeProvider notifier;
  final bool Function(PktbsTrx trx) condition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(employeeTrxsProvider(notifier.selectedEmployee!));
    final noti =
        ref.watch(employeeTrxsProvider(notifier.selectedEmployee!).notifier);
    final salary = notifier.selectedEmployee!.salary;
    final trxs = noti.rawTrxs.where(condition).toList();
    final adjusted = trxs.isEmpty
        ? 0.0
        : trxs
            .where((e) =>
                e.created.toLocal().month ==
                (noti.showPrevMonth
                    ? DateTime.now().previousMonth.month
                    : DateTime.now().month))
            .fold<double>(
                0.0,
                (p, c) =>
                    p -
                    (c.trxType.isCredit ? c.amount : 0.0) +
                    (c.trxType.isDebit ? c.amount : 0.0));
    final due = salary - adjusted;
    final kColor = due.isNegative ? Colors.green : Colors.red;
    return Row(
      children: [
        if (!noti.showPrevMonth)
          InkWell(
            borderRadius: borderRadius45,
            onTap: () => noti.toggleShowPrevMonth(),
            child: Container(
              padding: const EdgeInsets.fromLTRB(5.0, 15.0, 0.0, 15.0),
              margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
              child: const Icon(Icons.arrow_back_ios),
            ),
          ),
        Expanded(
          child: Card(
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
                  'Total orders summary for Month (${(noti.showPrevMonth ? DateTime.now().previousMonth : DateTime.now()).monthName})'),
              subtitle: Text(
                  'Salary: ${salary.formattedFloat} & Completed Orders: ${trxs.length} pc'),
              trailing: TweenAnimationBuilder(
                curve: Curves.easeOut,
                duration: kAnimationDuration(0.5),
                tween: Tween<double>(begin: 0, end: adjusted),
                builder: (_, double x, __) {
                  return Column(
                    crossAxisAlignment: crossEnd,
                    mainAxisAlignment: mainCenter,
                    children: [
                      Tooltip(
                        message: x.formattedFloat,
                        child: Text(
                          x.formattedCompat,
                          style: context.text.labelLarge!.copyWith(
                            color: kColor,
                          ),
                        ),
                      ),
                      Tooltip(
                        message: !due.isNegative
                            ? 'Loss: ${due.mod.formattedFloat}'
                            : 'Profit: ${due.mod.formattedFloat}',
                        child: Text(
                          !due.isNegative
                              ? 'Loss: ${due.formattedCompat}'
                              : 'Profit: ${due.mod.formattedCompat}',
                          style: context.text.bodySmall!.copyWith(
                            color: kColor.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        if (noti.showPrevMonth)
          InkWell(
            borderRadius: borderRadius45,
            onTap: () => noti.toggleShowPrevMonth(),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0.0, 15.0, 5.0, 15.0),
              margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
              child: const Icon(Icons.arrow_forward_ios),
            ),
          ),
      ],
    );
  }
}
