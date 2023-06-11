import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smiling_tailor/src/shared/animations_widget/animated_popup.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

Future<void> showOrderSlipDownloadPopup(
  BuildContext context,
  String orderId,
) async =>
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => OrderSlipDownloadPopup(orderId),
    );

class OrderSlipDownloadPopup extends StatelessWidget {
  const OrderSlipDownloadPopup(this.orderId, {super.key});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        title: const Text('Order Slip'),
        content: SizedBox(
          width: min(400, context.width),
          child: Text(
              'Your order #$orderId has been successfully added. Do you want to download the order slip?'),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Cancel',
              style:
                  TextStyle(color: context.theme.dividerColor.withOpacity(0.8)),
            ),
          ),
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Download',
              style: TextStyle(color: context.theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
