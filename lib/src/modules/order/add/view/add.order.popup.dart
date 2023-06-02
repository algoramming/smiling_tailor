import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/constants.dart';
import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../utils/extensions/extensions.dart';
import '../provider/add.order.provider.dart';
import 'components/customer.infos.dart';
import 'components/delivery.infos.dart';
import 'components/inventory.infos.dart';
import 'components/measurement.infos.dart';
import 'components/others.infos.dart';
import 'components/payment.infos.dart';
import 'components/tailor.infos.dart';

class AddOrderPopup extends ConsumerWidget {
  const AddOrderPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(addOrderProvider);
    final notifier = ref.read(addOrderProvider.notifier);
    return AnimatedPopup(
      child: AlertDialog(
        scrollable: true,
        title: const Text('Add Order'),
        content: SizedBox(
          width: min(400, context.width),
          child: Form(
            key: notifier.formKey,
            child: Column(
              mainAxisSize: mainMin,
              children: [
                CustomerInfos(notifier: notifier),
                MeasurementInfos(notifier: notifier),
                InventoryInfos(notifier: notifier),
                TailorInfos(notifier: notifier),
                DeliveryInfos(notifier: notifier),
                PaymentInfos(notifier: notifier),
                OthersInfos(notifier: notifier),
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
            child: Text(
              'Add Order',
              style: TextStyle(color: context.theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
