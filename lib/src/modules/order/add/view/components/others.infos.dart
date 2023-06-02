import 'package:flutter/material.dart';
import 'package:smiling_tailor/src/modules/settings/model/settings.model.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../../../constants/constants.dart';
import '../../../../../db/isar.dart';
import '../../../../../shared/date_time_picker/k_date_time_picker.dart';
import '../../../model/enum.dart';
import '../../provider/add.order.provider.dart';
import 'info.title.dart';

class OthersInfos extends StatelessWidget {
  const OthersInfos({super.key, required this.notifier});

  final AddOrderProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const InfoTitle('Others Information'),
        InkWell(
          onTap: () async =>
              await selectDateTimeFromPicker(context, notifier.deliveryTime)
                  .then((dt) {
            if (dt == null) return;
            notifier.setDeliveryTime(dt);
          }),
          child: Container(
            alignment: Alignment.center,
            height: 48.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: borderRadius12,
              border:
                  Border.all(color: context.text.bodyLarge!.color!, width: 1.0),
            ),
            child: Text(
              appSettings.getDateTimeFormat.format(notifier.deliveryTime),
              style: context.text.titleMedium,
            ),
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField(
          borderRadius: borderRadius12,
          value: notifier.status,
          decoration: const InputDecoration(
            labelText: 'Order Status',
            hintText: 'Select order status...',
          ),
          onChanged: (v) => notifier.setOrderStatus(v!),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          items: OrderStatus.values
              .map((e) => DropdownMenuItem(value: e, child: Text(e.label)))
              .toList(),
          validator: (v) {
            if (v == null) {
              return 'Payment method selection is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: notifier.descriptionCntrlr,
          decoration: const InputDecoration(
            labelText: 'Description',
            hintText: 'Enter description (if any)...',
          ),
          onFieldSubmitted: (_) async => notifier.submit(context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          validator: (v) => null,
        ),
      ],
    );
  }
}