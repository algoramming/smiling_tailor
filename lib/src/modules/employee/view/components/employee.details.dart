import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/constants.dart';
import '../../../../db/isar.dart';
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
              'No Employee Selected!\n Please select a employee see full information.',
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
              const SizedBox(height: 10),
              _TotalAmount(notifier),
            ],
          );
  }
}

class _TrxTable extends ConsumerWidget {
  const _TrxTable(this.notifier);

  final EmployeeProvider notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(employeeTrxsProvider(notifier.selectedEmployee!));
    final noti =
        ref.watch(employeeTrxsProvider(notifier.selectedEmployee!).notifier);
    return Expanded(
      child: noti.trxList.isEmpty
          ? const Center(
              child: Text('No Transaction Found!', textAlign: TextAlign.center))
          : ListView.builder(
              itemCount: noti.trxList.length,
              itemBuilder: (_, i) {
                final trx = noti.trxList[i];
                return Card(
                  color: i % 2 != 0
                      ? context.theme.primaryColor.withOpacity(0.2)
                      : null,
                  child: ListTile(
                    leading: Card(
                      color: trx.isReceiveable
                          ? Colors.green[100]
                          : Colors.red[100],
                      shape: roundedRectangleBorder10,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Transform.flip(
                          flipY: !trx.isReceiveable,
                          child: Icon(
                            Icons.arrow_outward_rounded,
                            size: 22.0,
                            color:
                                trx.isReceiveable ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    ),
                    title: Text(noti.trxList[i].createdDate),
                    subtitle: noti.trxList[i].description == null
                        ? null
                        : Text(noti.trxList[i].description!),
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
                      tween:
                          Tween<double>(begin: 0, end: noti.trxList[i].amount),
                      builder: (_, double x, __) {
                        return Text(
                          x.formattedCompat,
                          style: context.text.labelLarge!.copyWith(
                            color: noti.trxList[i].isReceiveable
                                ? Colors.green
                                : Colors.red,
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

class _TotalAmount extends ConsumerWidget {
  const _TotalAmount(this.notifier);

  final EmployeeProvider notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(employeeTrxsProvider(notifier.selectedEmployee!));
    final noti =
        ref.watch(employeeTrxsProvider(notifier.selectedEmployee!).notifier);
    final salary = notifier.selectedEmployee!.salary;
    final taken = noti.rawTrxs.isEmpty
        ? 0.0
        : noti.rawTrxs
            .where((e) =>
                !e.isReceiveable &&
                e.created.month ==
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
                    currency.symbol,
                    style: context.text.labelLarge!.copyWith(
                      color: due.isNegative ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ),
              title: Text(
                  'Total Due of this Month (${(noti.showPrevMonth ? DateTime.now().previousMonth : DateTime.now()).monthName})'),
              subtitle: Text(
                  'Salary: ${salary.formattedCompat} & Taken: ${taken.formattedCompat}'),
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
                tween: Tween<double>(begin: 0, end: due),
                builder: (_, double x, __) {
                  return Text(
                    x.formattedCompat,
                    style: context.text.labelLarge!.copyWith(
                      color: x.isNegative ? Colors.green : Colors.red,
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
