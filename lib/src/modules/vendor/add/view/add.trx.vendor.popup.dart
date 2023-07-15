import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../model/vendor.trx.dart';
import '../provider/add.trx.vendor.provider.dart';

class AddTrxVendorPopup extends ConsumerWidget {
  const AddTrxVendorPopup(this.vendorTrx, {super.key});

  final VendorTrx vendorTrx;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(addTrxVendorProvider(vendorTrx));
    final notifier = ref.read(addTrxVendorProvider(vendorTrx).notifier);
    return AnimatedPopup(
      child: AlertDialog(
        title: Text(
            vendorTrx.trx == null ? 'Add Transaction' : 'Edit Transaction'),
        content: SizedBox(
          width: min(400, context.width),
          child: Form(
            key: notifier.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'The amount will be added in ',
                    style: context.text.labelLarge,
                    children: [
                      TextSpan(
                        text: '${vendorTrx.vendor.name}\'s',
                        style: context.text.labelLarge!
                            .copyWith(color: context.theme.primaryColor),
                      ),
                      TextSpan(
                        text: ' statement.',
                        style: context.text.labelLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: notifier.amountCntrlr,
                        decoration: const InputDecoration(
                          labelText: 'Amount',
                          hintText: 'Enter employee\'s amount...',
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
                    ),
                    const SizedBox(width: 5.0),
                    Switch.adaptive(
                      value: notifier.isPaybale,
                      onChanged: (_) => notifier.toggleIsPayable(),
                    )
                  ],
                ),
                const SizedBox(height: 3),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    notifier.isPaybale
                        ? '• This amount will be deducted from this vendor. (Accounts Payable)'
                        : '• This amount will be added to this vendor. (Accounts Receivable)',
                    style: context.text.bodySmall!.copyWith(
                      color: context.theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.descriptionCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter any Description (if have)...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  validator: (v) => null,
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
                vendorTrx.trx == null
                    ? 'Add Transaction'
                    : 'Update Transaction',
                style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
