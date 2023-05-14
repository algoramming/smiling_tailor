import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../../shared/animations_widget/animated_popup.dart';
import '../provider/add.employee.provider.dart';

class AddEmployeePopup extends ConsumerWidget {
  const AddEmployeePopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(addEmployeeProvider);
    final notifier = ref.read(addEmployeeProvider.notifier);
    return AnimatedPopup(
      child: AlertDialog(
        title: const Text('Add Employee'),
        content: SizedBox(
          width: min(400, context.width),
          child: Form(
            key: notifier.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: notifier.nameCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Employee Name',
                    hintText: 'Enter employee\'s name...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.addressCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Employee Address',
                    hintText: 'Enter employee\'s address...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Address is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.phoneCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Employee Phone',
                    hintText: 'Enter employee\'s phone number...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Phone number is required';
                    }
                    if (!v.isPhone) {
                      return 'Invalid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.emailCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Employee Email',
                    hintText: 'Enter employee\'s email address...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v!.isNotEmpty && !v.isEmail) {
                      return 'Invalid email';
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
                  validator: (v) {
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notifier.salaryCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Salary',
                    hintText: 'Enter employee\'s salary...',
                  ),
                  onFieldSubmitted: (_) async => notifier.submit(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Opening balance is required';
                    }
                    if (!v.isNumeric) {
                      return 'Invalid opening balance';
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
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async => await notifier.submit(context),
            child: const Text('Add Employee',
                style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }
}
