import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/transaction/enum/trx.type.dart';

import '../../../../config/constants.dart';
import '../../../../db/isar.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';
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
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: Icon(Icons.search),
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
              // const SizedBox(height: 10),
              // _TotalAmount(notifier),
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
                isScrollable: true,
                physics: const BouncingScrollPhysics(),
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
        _TrxList(notifier, condition: (t) => t.fromType == GLType.user),
        const SizedBox(height: 10),
        _TotalSummary(
          notifier,
          (t) => t.fromType == GLType.user,
          isOrder: false,
        ),
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
        _TrxList(notifier, condition: (t) => t.fromType == GLType.order),
        const SizedBox(height: 10),
        _TotalSummary(
          notifier,
          (t) => t.fromType == GLType.order,
          isOrder: true,
        ),
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
          ? const Center(
              child: Text('No Transaction Found!', textAlign: TextAlign.center))
          : ListView.builder(
              itemCount: trxs.length,
              itemBuilder: (_, i) {
                final trx = trxs[i];
                return Card(
                  child: KListTile(
                    leading: Card(
                      color: Colors.red[100],
                      shape: roundedRectangleBorder10,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Transform.flip(
                          flipY: true,
                          child: const Icon(
                            Icons.arrow_outward_rounded,
                            size: 22.0,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    title: Text(noti.trxList[i].createdDate),
                    subtitle:
                        trx.description == null ? null : Text(trx.description!),
                    // trailing: Text(
                    //   noti.trxList[i].amount.formattedCompat,
                    //   style: context.text.labelLarge!.copyWith(
                    //     color: noti.trxList[i].isReceiveable
                    //         ? Colors.green
                    //         : Colors.red,
                    //   ),
                    // ),
                    trailing: TweenAnimationBuilder(
                      curve: Curves.easeOut,
                      duration: kAnimationDuration(0.5),
                      tween: Tween<double>(begin: 0, end: trx.amount),
                      builder: (_, double x, __) {
                        return Tooltip(
                          message: x.formattedFloat,
                          child: Text(
                            x.formattedCompat,
                            style: context.text.labelLarge!.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _TotalSummary extends ConsumerWidget {
  const _TotalSummary(this.notifier, this.condition, {this.isOrder = false});

  final EmployeeProvider notifier;
  final bool Function(PktbsTrx trx) condition;
  final bool isOrder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(employeeTrxsProvider(notifier.selectedEmployee!));
    final noti =
        ref.watch(employeeTrxsProvider(notifier.selectedEmployee!).notifier);
    final salary = notifier.selectedEmployee!.salary;
    final trxs = noti.rawTrxs.where(condition).toList();
    final taken = trxs.isEmpty
        ? 0.0
        : trxs
            .where((e) =>
                e.created.toLocal().month ==
                (noti.showPrevMonth
                    ? DateTime.now().previousMonth.month
                    : DateTime.now().month))
            .fold<double>(0.0, (p, c) => p + c.amount);
    final due = salary - taken;
    return Row(
      children: [
        if (!noti.showPrevMonth)
          InkWell(
            onTap: () => noti.toggleShowPrevMonth(),
            child: const Icon(Icons.arrow_back_ios),
          ),
        Expanded(
          child: Card(
            color: context.theme.dividerColor.withOpacity(0.2),
            child: ListTile(
              leading: Card(
                color: due.isNegative ? Colors.green[100] : Colors.red[100],
                shape: roundedRectangleBorder10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  child: Text(
                    appCurrency.symbol,
                    style: context.text.labelLarge!.copyWith(
                      color: due.isNegative ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ),
              title: Text(
                  '${isOrder ? 'Total completed orders' : 'Total owe'} for Month (${(noti.showPrevMonth ? DateTime.now().previousMonth : DateTime.now()).monthName})'),
              subtitle: isOrder
                  ? Text(
                      'Total Order: ${trxs.length} pcs & Earned: ${taken.formattedFloat}')
                  : Text(
                      'Salary: ${salary.formattedFloat} & Taken: ${taken.formattedFloat}'),
              // trailing: Text(due.formattedCompat,
              //   style: context.text.labelLarge!.copyWith(
              //     color: noti.trxList.isEmpty
              //         ? Colors.black
              //         : noti.trxList
              //                     .map((e) => e.isReceiveable ? e.amount : -e.amount)
              //                     .reduce((value, element) => value + element) >=
              //                 0
              //             ? Colors.green
              //             : Colors.red,
              //   ),
              // ),
              trailing: TweenAnimationBuilder(
                curve: Curves.easeOut,
                duration: kAnimationDuration(0.5),
                tween: Tween<double>(begin: 0, end: isOrder ? taken : due),
                builder: (_, double x, __) {
                  return Tooltip(
                    message: x.formattedFloat,
                    child: Text(
                      x.formattedCompat,
                      style: context.text.labelLarge!.copyWith(
                        color: x.isNegative ? Colors.green : Colors.red,
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
            onTap: () => noti.toggleShowPrevMonth(),
            child: const Icon(Icons.arrow_forward_ios),
          ),
      ],
    );
  }
}
