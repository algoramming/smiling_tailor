import 'package:flutter/material.dart';

import '../../../../../config/constants.dart';
import '../../../../../utils/extensions/extensions.dart';
import '../../provider/add.order.provider.dart';
import 'info.title.dart';

class CustomerInfos extends StatelessWidget {
  const CustomerInfos({super.key, required this.notifier});

  final AddOrderProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: mainMin,
      children: [
        const InfoTitle('Customer Information'),
        TextFormField(
          controller: notifier.customerNameCntrlr,
          decoration: const InputDecoration(
            labelText: 'Customer Name',
            hintText: 'Enter customer\'s name...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          validator: (v) {
            if (v!.isEmpty) {
              return 'Customer name is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: notifier.customerEmailCntrlr,
          decoration: const InputDecoration(
            labelText: 'Customer Email',
            hintText: 'Enter customer\'s email address...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          validator: (v) {
            if (v!.isNotEmpty && !v.isEmail) {
              return 'Invalid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: notifier.customerPhoneCntrlr,
          decoration: const InputDecoration(
            labelText: 'Customer Phone',
            hintText: 'Enter customer\'s phone number...',
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
          controller: notifier.customerAddressCntrlr,
          decoration: const InputDecoration(
            labelText: 'Customer Address',
            hintText: 'Enter customer\'s address...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          validator: (v) => null,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: notifier.customerNoteCntrlr,
          decoration: const InputDecoration(
            labelText: 'Customer Note',
            hintText: 'Enter customer\'s note (if any)...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          validator: (v) => null,
        ),
      ],
    );
  }
}
