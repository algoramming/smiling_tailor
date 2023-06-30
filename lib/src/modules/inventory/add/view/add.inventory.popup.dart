import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/inventory/model/inventory.dart';

import '../../../../config/constants.dart';
import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../../utils/extensions/extensions.dart';
import '../provider/add.inventory.provider.dart';

class AddInventoryPopup extends ConsumerWidget {
  const AddInventoryPopup({super.key, this.inventory});

  final PktbsInventory? inventory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(addInventoryProvider(inventory));
    final notifier = ref.read(addInventoryProvider(inventory).notifier);
    return AnimatedPopup(
      child: AlertDialog(
        title: Text(inventory == null ? 'Add Inventory' : 'Edit Inventory'),
        content: SizedBox(
          width: min(400, context.width),
          child: Form(
            key: notifier.formKey,
            child: Column(
              mainAxisSize: mainMin,
              children: [
                DropdownButtonFormField(
                  borderRadius: borderRadius15,
                  value: notifier.from,
                  decoration: const InputDecoration(
                    labelText: 'Vendor',
                    hintText: 'From where you buy this inventory...',
                  ),
                  onChanged: (v) => notifier.setCreatedFrom(v!),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  items: notifier.vendors
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.name)))
                      .toList(),
                  validator: (v) {
                    if (v == null) {
                      return 'Vendor selection is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.titleCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Inventory Title',
                    hintText: 'Enter inventory\'s title...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.descriptionCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter any Description (if have)...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  validator: (v) => null,
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: crossStart,
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        controller: notifier.quantityCntrlr,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          hintText: 'Enter inventory\'s quantity...',
                          suffixIcon: CurrencySuffixIcon(
                              text: notifier.unit?.symbol ?? '??'),
                        ),
                        onFieldSubmitted: (_) async => notifier.submit(context),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Quantity is required';
                          }
                          if (!v.isNumeric) {
                            return 'Invalid quantity';
                          }
                          if (!v.isInt) {
                            return 'Quantity must be integer';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField(
                        borderRadius: borderRadius15,
                        value: notifier.unit,
                        decoration: const InputDecoration(
                          labelText: 'Unit',
                          hintText: 'Select',
                        ),
                        onChanged: (v) => notifier.setUnit(v!),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        items: notifier.measurements
                            .map((e) => DropdownMenuItem(
                                value: e, child: Text(e.symbol, maxLines: 1)))
                            .toList(),
                        validator: (v) {
                          if (v == null) {
                            return 'required*';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.amountCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Total Amount',
                    hintText: 'Enter inventory\'s amount...',
                    suffixIcon: CurrencySuffixIcon(),
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Amount is required';
                    }
                    if (!v.isNumeric) {
                      return 'Invalid amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.advanceCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Advance Payment',
                    hintText: 'Enter inventory\'s advance payment...',
                    suffixIcon: CurrencySuffixIcon(),
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v!.isEmpty && !v.isNumeric) {
                      return 'Invalid amount';
                    }
                    if (notifier.amountCntrlr.text.isNotEmpty &&
                        double.parse(v) >
                            double.parse(notifier.amountCntrlr.text)) {
                      return 'Advance payment must be less than total amount';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Cancel',
              style:
                  TextStyle(color: context.theme.dividerColor.withOpacity(0.8)),
            ),
          ),
          TextButton(
            onPressed: () async => await notifier.submit(context),
            child: Text(
                inventory == null ? 'Add Inventory' : 'Update Inventory',
                style: TextStyle(color: context.theme.primaryColor)),
          ),
        ],
      ),
    );
  }
}
