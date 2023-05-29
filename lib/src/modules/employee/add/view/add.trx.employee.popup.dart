import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/animations_widget/animated_popup.dart';
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
                        text: ' salary. [Total Salary: ',
                        style: context.text.labelLarge,
                      ),
                      TextSpan(
                        text: employee.salary.toString(),
                        style: context.text.labelLarge!
                            .copyWith(color: context.theme.primaryColor),
                      ),
                      TextSpan(
                        text: ']',
                        style: context.text.labelLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.amountCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    hintText: 'Enter employee\'s amount...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
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
            child: const Text('Add Transaction',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
