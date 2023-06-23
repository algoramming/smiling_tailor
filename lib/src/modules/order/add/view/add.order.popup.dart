import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants.dart';
import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../shared/error_widget/error_widget.dart';
import '../../../../shared/loading_widget/loading_widget.dart';
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
          child: ref.watch(addOrderProvider).when(
                loading: () => const LoadingWidget(withScaffold: false),
                error: (err, _) => KErrorWidget(error: err),
                data: (_) => Form(
                  key: notifier.formKey,
                  child: Column(
                    mainAxisSize: mainMin,
                    children: [
                      CustomerInfos(notifier: notifier),
                      MeasurementInfos(notifier: notifier),
                      TailorInfos(notifier: notifier),
                      InventoryInfos(notifier: notifier),
                      DeliveryInfos(notifier: notifier),
                      PaymentInfos(notifier: notifier),
                      OthersInfos(notifier: notifier),
                    ],
                  ),
                ),
              ),
        ),
        actions: [
          TextButton(
            onPressed: () async => context.pop(),
            child: Text(
              'Cancel',
              style:
                  TextStyle(color: context.theme.dividerColor.withOpacity(0.8)),
            ),
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
