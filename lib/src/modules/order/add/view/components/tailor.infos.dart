import 'package:flutter/material.dart';

import '../../../../../config/constants.dart';
import '../../../../../utils/extensions/extensions.dart';
import '../../provider/add.order.provider.dart';

class TailorInfos extends StatelessWidget {
  const TailorInfos({super.key, required this.notifier});

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
          initiallyExpanded: notifier.allocateTailorNow,
          title: const Text('• Do you want to allocate tailor now?'),
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
              notifier.allocateTailorNow ? 'Yes' : 'No',
              style: context.text.labelMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onExpansionChanged: notifier.toggleAllocateTailorNow,
          children: [
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
                if (notifier.allocateTailorNow && v == null) {
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
                if (notifier.allocateTailorNow &&
                    v!.isNotEmpty &&
                    !v.isNumeric) {
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
        ),
      ),
    );
  }
}
