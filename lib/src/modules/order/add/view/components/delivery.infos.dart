import 'package:flutter/material.dart';

import '../../../../../config/constants.dart';
import '../../../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../../../utils/extensions/extensions.dart';
import '../../provider/add.order.provider.dart';

class DeliveryInfos extends StatelessWidget {
  const DeliveryInfos({super.key, required this.notifier});

  final AddOrderProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        borderRadius: borderRadius12,
        border: Border.all(
          color: context.theme.primaryColor,
          width: 1.2,
        ),
      ),
      child: Theme(
        data: context.theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: roundedRectangleBorder12,
          childrenPadding: const EdgeInsets.fromLTRB(4, 10, 4, 4),
          initiallyExpanded: notifier.isHomeDeliveryNeeded,
          title: const Text('• Do the customer need home delivery?'),
          trailing: Container(
            height: 22.0,
            width: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: borderRadius45,
              color: context.theme.primaryColor.withOpacity(0.3),
              border: Border.all(
                color: context.theme.primaryColor,
                width: 1.3,
              ),
            ),
            child: Text(
              notifier.isInventoryNeeded ? 'Yes' : 'No',
              style: context.text.labelMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onExpansionChanged: notifier.toggleHomeDeliveryNeeded,
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
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                  .toList(),
              validator: (v) {
                if (notifier.isHomeDeliveryNeeded && v == null) {
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
                validator: (v) {
                  if (notifier.isHomeDeliveryNeeded && v!.isEmpty) {
                    return 'Delivery address is required';
                  }
                  return null;
                }),
            const SizedBox(height: 10),
            TextFormField(
              controller: notifier.deliveryChargeCntrlr,
              decoration: const InputDecoration(
                labelText: 'Delivery Charge',
                hintText: 'Enter delivery charge...',
                suffixIcon: CurrencySuffixIcon(),
              ),
              onFieldSubmitted: (_) async => notifier.submit(context),
              onChanged: (_) => notifier.reload(),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (v) {
                if (notifier.isHomeDeliveryNeeded &&
                    v!.isNotEmpty &&
                    !v.isNumeric) {
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
    );
  }
}
