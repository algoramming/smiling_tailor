import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../db/db.dart';
import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../model/employee.dart';
import '../provider/add.trx.employee.provider.dart';

class AddTrxEmployeePopup extends ConsumerWidget {
  const AddTrxEmployeePopup(this.employee, {super.key});

  final PktbsEmployee employee;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(addTrxEmployeeProvider(employee));
    final notifier = ref.read(addTrxEmployeeProvider(employee).notifier);
    return AnimatedPopup(
      child: AlertDialog(
        title: const Text('Add Transaction'),
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
                    text: 'The amount will be deducted from ',
                    style: context.text.labelLarge,
                    children: [
                      TextSpan(
                        text: '${employee.name}\'s',
                        style: context.text.labelLarge!
                            .copyWith(color: context.theme.primaryColor),
                      ),
                      TextSpan(
                        text: ' salary. [ Total Salary: ',
                        style: context.text.labelLarge,
                      ),
                      TextSpan(
                        text: employee.salary.toString(),
                        style: context.text.labelLarge!
                            .copyWith(color: context.theme.primaryColor),
                      ),
                      TextSpan(
                        text: '${appCurrency.symbol} ]',
                        style: context.text.labelLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                        ? '• This Employee owe from you. (Accounts Payable)'
                        : '• You\'re owe to this Employee. (Accounts Receivable)',
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
            child: const Text('Add Transaction',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
