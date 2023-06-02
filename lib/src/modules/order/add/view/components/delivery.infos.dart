import 'package:flutter/material.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';
import 'package:smiling_tailor/src/utils/transations/big.to.small.dart';

import '../../../../../constants/constants.dart';
import '../../provider/add.order.provider.dart';
import 'info.title.dart';

class DeliveryInfos extends StatelessWidget {
  const DeliveryInfos({super.key, required this.notifier});

  final AddOrderProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const InfoTitle('Delivery Information'),
        SwitchListTile.adaptive(
          title: const Text('Is Home Delivery Needed?'),
          value: notifier.isHomeDeliveryNeeded,
          onChanged: (_) => notifier.toggleHomeDelivery(),
        ),
        const SizedBox(height: 10),
        BigToSmallTransition(
          child: !notifier.isHomeDeliveryNeeded
              ? const SizedBox.shrink()
              : Column(
                  mainAxisSize: mainMin,
                  children: [
                    DropdownButtonFormField(
                      borderRadius: borderRadius12,
                      value: notifier.deliveryEmployee,
                      decoration: const InputDecoration(
                        labelText: 'Delivery Employee',
                        hintText: 'Select employee to delivery this order...',
                      ),
                      onChanged: (v) => notifier.setDeliveryEmployee(v!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      items: notifier.employees
                          .map((e) =>
                              DropdownMenuItem(value: e, child: Text(e.name)))
                          .toList(),
                      validator: (v) {
                        if (v == null) {
                          return 'Employee selection is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: notifier.deliveryAddressCntrlr,
                      decoration: const InputDecoration(
                        labelText: 'Delivery Address',
                        hintText: 'Enter delivery address...',
                      ),
                      onFieldSubmitted: (_) async => notifier.submit(context),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (v) => null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: notifier.deliveryChargeCntrlr,
                      decoration: const InputDecoration(
                        labelText: 'Delivery Charge',
                        hintText: 'Enter delivery charge...',
                      ),
                      onFieldSubmitted: (_) async => notifier.submit(context),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v!.isNotEmpty && !v.isNumeric) {
                          return 'Invalid amount';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: notifier.deliveryNoteCntrlr,
                      decoration: const InputDecoration(
                        labelText: 'Delivery Note',
                        hintText: 'Enter delivery note (if any)...',
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
      ],
    );
  }
}
