import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/employee/add/view/add.trx.employee.popup.dart';
import 'package:smiling_tailor/src/modules/settings/model/settings.model.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../../../main.dart';
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
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton.icon(
                  onPressed: () async => await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        AddTrxEmployeePopup(notifier.selectedEmployee!),
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Transaction'),
                ),
              ),
              const SizedBox(height: 10),
              _TrxTable(notifier),
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
              child: Text(
                'No Transaction Found!',
                textAlign: TextAlign.center,
              ),
            )
          : Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(2),
              },
              children: [
                const TableRow(
                  children: [
                    TableCell(
                      child: Text('Date'),
                    ),
                    TableCell(
                      child: Text('Amount'),
                    ),
                    TableCell(
                      child: Text('Created By'),
                    ),
                    TableCell(
                      child: Text('Updated By'),
                    ),
                  ],
                ),
                ...noti.trxList.map(
                  (e) => TableRow(
                    children: [
                      TableCell(
                        child: Text(
                            appSettings.getDateTimeFormat.format(e.created)),
                      ),
                      TableCell(
                        child: Text(e.amount.formattedCompat),
                      ),
                      TableCell(
                        child: Text(e.createdBy.name),
                      ),
                      TableCell(
                        child: Text(e.updatedBy?.name ?? ''),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
