import 'package:flutter/material.dart';

import '../../../../../config/constants.dart';
import '../../../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../../../utils/extensions/extensions.dart';
import '../../provider/add.order.provider.dart';

class InventoryInfos extends StatelessWidget {
  const InventoryInfos({super.key, required this.notifier});

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
          initiallyExpanded: notifier.isInventoryNeeded,
          title: const Text('• Do the customer purchase inventory?'),
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
              style: context.text.labelMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          onExpansionChanged: notifier.toggleInventoryNeeded,
          children: [
            DropdownButtonFormField(
              borderRadius: borderRadius12,
              value: notifier.inventory,
              decoration: const InputDecoration(
                labelText: 'Inventory',
                hintText: 'Select inventory to allocate this order...',
              ),
              onChanged: (v) => notifier.setInventory(v!),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              items: notifier.inventories
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.title)))
                  .toList(),
              validator: (v) {
                if (notifier.isInventoryNeeded && v == null) {
                  return 'Inventory selection is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: notifier.inventoryQuantityCntrlr,
              decoration: InputDecoration(
                labelText: 'Inventory Quantity',
                hintText: 'Enter inventory\'s quantity...',
                suffixIcon: CurrencySuffixIcon(
                    text: notifier.inventoryUnit?.symbol ?? '??'),
              ),
              onFieldSubmitted: (_) async => notifier.submit(context),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (v) {
                if (notifier.isInventoryNeeded && v!.isEmpty) {
                  return 'Quantity is required';
                }
                if (notifier.isInventoryNeeded && !v!.isNumeric) {
                  return 'Invalid quantity';
                }
                if (notifier.isInventoryNeeded && !v!.isInt) {
                  return 'Quantity must be integer';
                }
                if (notifier.isInventoryNeeded &&
                    int.parse(v!) > notifier.inventoryLeft) {
                  return 'Quantity must be less than or equal to ${notifier.inventoryLeft} ${notifier.inventoryUnit?.symbol ?? '??'}';
                }
                return null;
              },
            ),
            const SizedBox(height: 3),
            if (notifier.inventoryLeft != 0)
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Total ${notifier.inventoryLeft}${notifier.inventoryUnit?.symbol ?? '??'} available in stock. (${notifier.inventory?.quantity}${notifier.inventory?.unit.symbol}/${notifier.inventory?.amount})',
                  style: context.text.labelMedium,
                ),
              ),
            const SizedBox(height: 7),
            TextFormField(
              controller: notifier.inventoryPriceCntrlr,
              decoration: const InputDecoration(
                labelText: 'Inventory Charge',
                hintText: 'Enter inventory charge...',
                suffixIcon: CurrencySuffixIcon(),
              ),
              onFieldSubmitted: (_) async => notifier.submit(context),
              onChanged: (_) => notifier.reload(),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (v) {
                if (notifier.isInventoryNeeded && v!.isEmpty) {
                  return 'Inventory Charge is required';
                }
                if (notifier.isInventoryNeeded && !v!.isNumeric) {
                  return 'Invalid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: notifier.inventoryNoteCntrlr,
              decoration: const InputDecoration(
                labelText: 'Inventory Note',
                hintText: 'Enter inventory note (if any)...',
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
