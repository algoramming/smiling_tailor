import 'package:flutter/material.dart';

import '../../../../../config/constants.dart';
import '../../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../../utils/extensions/extensions.dart';
import '../../provider/add.order.provider.dart';
import 'info.title.dart';

class InventoryInfos extends StatelessWidget {
  const InventoryInfos({super.key, required this.notifier});

  final AddOrderProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const InfoTitle('Inventory Information'),
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
            if (v == null) {
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
            suffixIcon: AnimatedWidgetShower(
              size: 28.0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                child: Center(
                  child: Text(
                    notifier.inventoryUnit?.symbol ?? '??',
                    style: context.text.labelLarge,
                  ),
                ),
              ),
            ),
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.done,
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
        const SizedBox(height: 10),
        TextFormField(
          controller: notifier.inventoryPriceCntrlr,
          decoration: const InputDecoration(
            labelText: 'Inventory Charge',
            hintText: 'Enter inventory charge...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v!.isEmpty) {
              return 'Inventory Charge is required';
            }
            if (!v.isNumeric) {
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
    );
  }
}
