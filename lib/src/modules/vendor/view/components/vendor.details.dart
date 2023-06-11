import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants.dart';
import '../../../../db/isar.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../settings/model/settings.model.dart';
import '../../../transaction/model/transaction.dart';
import '../../add/view/add.vendor.popup.dart';
import '../../provider/vendor.provider.dart';
import '../../provider/vendor.trxs.provider.dart';

// class VendorDetails extends StatelessWidget {
//   const VendorDetails({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         '$appName - Vendors',
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }

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
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 6.0),
                  OutlinedButton.icon(
                    onPressed: () async {
                      // Add Transaction
                      //   await showDialog(
                      //   context: context,
                      //   barrierDismissible: false,
                      //   builder: (context) =>
                      //       AddTrxEmployeePopup(notifier.selectedEmployee!),
                      // );
                    },
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

  final VendorProvider notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(vendorTrxsProvider(notifier.selectedVendor!));
    final noti =
        ref.watch(vendorTrxsProvider(notifier.selectedVendor!).notifier);
    return Expanded(
      child: noti.trxList.isEmpty
          ? const Center(
              child: Text('No Transaction Found!', textAlign: TextAlign.center))
          : ListView.builder(
              itemCount: noti.trxList.length,
              itemBuilder: (_, i) {
                final trx = noti.trxList[i];
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
                      tween:
                          Tween<double>(begin: 0, end: noti.trxList[i].amount),
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

class _TotalAmount extends ConsumerWidget {
  const _TotalAmount(this.notifier);

  final VendorProvider notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(vendorTrxsProvider(notifier.selectedVendor!));
    final noti =
        ref.watch(vendorTrxsProvider(notifier.selectedVendor!).notifier);
    final given = noti.rawTrxs.isEmpty
        ? 0.0
        : noti.rawTrxs.fold<double>(0.0, (p, c) => p + c.amount);
    final due = noti.totalPurchase - given;
    return Card(
      color: context.theme.dividerColor.withOpacity(0.2),
      child: ListTile(
        leading: Card(
          color: due.isNegative ? Colors.green[100] : Colors.red[100],
          shape: roundedRectangleBorder10,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Text(
              appCurrency.symbol,
              style: context.text.labelLarge!.copyWith(
                color: due.isNegative ? Colors.green : Colors.red,
              ),
            ),
          ),
        ),
        title: Text(
            'Total Due till now ${appSettings.getDateTimeFormat.format(DateTime.now())}'),
        subtitle: Text(
            'Total Purchase: ${noti.totalPurchase.formattedCompat} & Given: ${given.formattedCompat}'),
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
    );
  }
}
