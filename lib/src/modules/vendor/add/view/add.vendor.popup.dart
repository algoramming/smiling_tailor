import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../../shared/animations_widget/animated_popup.dart';
import '../provider/add.vendor.provider.dart';

class AddVendorPopup extends ConsumerWidget {
  const AddVendorPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(addVendorProvider);
    final notifier = ref.read(addVendorProvider.notifier);
    return AnimatedPopup(
      child: AlertDialog(
        title: const Text('Add Vendor'),
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
                    labelText: 'Vendor Name',
                    hintText: 'Enter vendor\'s name...',
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
                    labelText: 'Vendor Address',
                    hintText: 'Enter vendor\'s address...',
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
                    labelText: 'Vendor Phone',
                    hintText: 'Enter vendor\'s phone number...',
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
                    labelText: 'Vendor Email',
                    hintText: 'Enter vendor\'s email address...',
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
                  controller: notifier.openingBalanceCntrlr,
                  decoration: const InputDecoration(
                    labelText: 'Opening Balance',
                    hintText: 'Enter vendor\'s opening balance...',
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
            child:
                const Text('Add Vendor', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }
}
