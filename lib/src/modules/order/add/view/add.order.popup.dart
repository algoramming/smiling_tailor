import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/constants.dart';
import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../utils/extensions/extensions.dart';
import '../provider/add.order.provider.dart';

class AddOrderPopup extends ConsumerWidget {
  const AddOrderPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(addOrderProvider);
    final notifier = ref.read(addOrderProvider.notifier);
    return AnimatedPopup(
      child: AlertDialog(
        title: const Text('Add Order'),
        content: SizedBox(
          width: min(400, context.width),
          child: Form(
            key: notifier.formKey,
            child: const Column(
              mainAxisSize: mainMin,
              children: [
                // DropdownButtonFormField(
                //   borderRadius: borderRadius15,
                //   value: notifier.createdFrom,
                //   decoration: const InputDecoration(
                //     labelText: 'Vendor',
                //     hintText: 'From where you buy this inventory...',
                //   ),
                //   onChanged: (v) => notifier.setCreatedFrom(v!),
                //   autovalidateMode: AutovalidateMode.onUserInteraction,
                //   items: notifier.vendors
                //       .map((e) =>
                //           DropdownMenuItem(value: e, child: Text(e.name)))
                //       .toList(),
                //   validator: (v) {
                //     if (v == null) {
                //       return 'Vendor selection is required';
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(height: 10),
                // TextFormField(
                //   controller: notifier.titleCntrlr,
                //   decoration: const InputDecoration(
                //     labelText: 'Inventory Title',
                //     hintText: 'Enter inventory\'s title...',
                //   ),
                //   onFieldSubmitted: (_) async => notifier.submit(context),
                //   autovalidateMode: AutovalidateMode.onUserInteraction,
                //   textInputAction: TextInputAction.next,
                //   keyboardType: TextInputType.name,
                //   validator: (v) {
                //     if (v!.isEmpty) {
                //       return 'Title is required';
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(height: 10),
                // TextFormField(
                //   controller: notifier.descriptionCntrlr,
                //   decoration: const InputDecoration(
                //     labelText: 'Description',
                //     hintText: 'Enter any Description (if have)...',
                //   ),
                //   onFieldSubmitted: (_) async => notifier.submit(context),
                //   autovalidateMode: AutovalidateMode.onUserInteraction,
                //   textInputAction: TextInputAction.next,
                //   keyboardType: TextInputType.text,
                //   validator: (v) => null,
                // ),
                // const SizedBox(height: 10),
                // Row(
                //   crossAxisAlignment: crossStart,
                //   children: [
                //     Expanded(
                //       flex: 5,
                //       child: TextFormField(
                //         controller: notifier.quantityCntrlr,
                //         decoration: const InputDecoration(
                //           labelText: 'Quantity',
                //           hintText: 'Enter inventory\'s quantity...',
                //         ),
                //         onFieldSubmitted: (_) async => notifier.submit(context),
                //         autovalidateMode: AutovalidateMode.onUserInteraction,
                //         textInputAction: TextInputAction.done,
                //         keyboardType: TextInputType.number,
                //         validator: (v) {
                //           if (v!.isEmpty) {
                //             return 'Quantity is required';
                //           }
                //           if (!v.isNumeric) {
                //             return 'Invalid quantity';
                //           }
                //           if (!v.isInt) {
                //             return 'Quantity must be integer';
                //           }
                //           return null;
                //         },
                //       ),
                //     ),
                //     const SizedBox(width: 10),
                //     Expanded(
                //       flex: 2,
                //       child: DropdownButtonFormField(
                //         borderRadius: borderRadius15,
                //         value: notifier.unit,
                //         decoration: const InputDecoration(
                //           labelText: 'Unit',
                //           hintText: 'Select',
                //         ),
                //         onChanged: (v) => notifier.setUnit(v!),
                //         autovalidateMode: AutovalidateMode.onUserInteraction,
                //         items: notifier.measurements
                //             .map((e) => DropdownMenuItem(
                //                 value: e, child: Text(e.symbol, maxLines: 1)))
                //             .toList(),
                //         validator: (v) {
                //           if (v == null) {
                //             return 'required*';
                //           }
                //           return null;
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 10),
                // TextFormField(
                //   controller: notifier.amountCntrlr,
                //   decoration: const InputDecoration(
                //     labelText: 'Total Amount',
                //     hintText: 'Enter inventory\'s amount...',
                //   ),
                //   onFieldSubmitted: (_) async => notifier.submit(context),
                //   autovalidateMode: AutovalidateMode.onUserInteraction,
                //   textInputAction: TextInputAction.done,
                //   keyboardType: TextInputType.number,
                //   validator: (v) {
                //     if (v!.isEmpty) {
                //       return 'Amount is required';
                //     }
                //     if (!v.isNumeric) {
                //       return 'Invalid amount';
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(height: 10),
                // TextFormField(
                //   controller: notifier.advanceCntrlr,
                //   decoration: const InputDecoration(
                //     labelText: 'Advance Payment',
                //     hintText: 'Enter inventory\'s advance payment...',
                //   ),
                //   onFieldSubmitted: (_) async => notifier.submit(context),
                //   autovalidateMode: AutovalidateMode.onUserInteraction,
                //   textInputAction: TextInputAction.done,
                //   keyboardType: TextInputType.number,
                //   validator: (v) {
                //     if (v!.isEmpty) {
                //       return 'Amount is required';
                //     }
                //     if (!v.isNumeric) {
                //       return 'Invalid amount';
                //     }
                //     if (notifier.amountCntrlr.text.isNotEmpty &&
                //         double.parse(v) >
                //             double.parse(notifier.amountCntrlr.text)) {
                //       return 'Advance payment must be less than total amount';
                //     }
                //     return null;
                //   },
                // ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async => await notifier.submit(context),
            child: Text('Add Inventory',
                style: TextStyle(color: context.theme.primaryColor)),
          ),
        ],
      ),
    );
  }
}
