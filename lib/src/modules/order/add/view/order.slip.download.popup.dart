import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../shared/clipboard_data/clipboard_data.dart';
import '../../../../utils/extensions/extensions.dart';

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
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Your order ',
              style: context.text.labelLarge,
              children: [
                TextSpan(
                  text: '#$orderId',
                  style: context.text.labelLarge!
                      .copyWith(color: context.theme.primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () async => await copyToClipboard(context, orderId),
                ),
                TextSpan(
                  text:
                      ' has been successfully added. Do you want to download the order slip?',
                  style: context.text.labelLarge,
                ),
              ],
            ),
          ),
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
