import 'package:flutter/material.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../../../constants/constants.dart';
import '../../provider/add.order.provider.dart';
import 'info.title.dart';

class TailorInfos extends StatelessWidget {
  const TailorInfos({super.key, required this.notifier});

  final AddOrderProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const InfoTitle('Tailor Allocation'),
        DropdownButtonFormField(
          borderRadius: borderRadius12,
          value: notifier.tailorEmployee,
          decoration: const InputDecoration(
            labelText: 'Tailor',
            hintText: 'Select tailor to allocate this order...',
          ),
          onChanged: (v) => notifier.setTailorEmployee(v!),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          items: notifier.employees
              .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
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
          controller: notifier.tailorChargeCntrlr,
          decoration: const InputDecoration(
            labelText: 'Tailoring Charge',
            hintText: 'Enter tailoring charge...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v!.isEmpty) {
              return 'Tailoring Charge is required';
            }
            if (!v.isNumeric) {
              return 'Invalid amount';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: notifier.tailorNoteCntrlr,
          decoration: const InputDecoration(
            labelText: 'Tailoring Note',
            hintText: 'Enter tailoring note (if any)...',
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
