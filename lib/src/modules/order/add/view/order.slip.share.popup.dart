import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smiling_tailor/src/shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import 'package:smiling_tailor/src/shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';

import '../../../../config/constants.dart';
import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../utils/extensions/extensions.dart';
import '../pdf/file.handle.dart';

Future<void> showOrderSlipSharePopup(
  BuildContext context,
  List<File> files,
) async =>
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => OrderSlipSharePopup(files),
    );

class OrderSlipSharePopup extends StatelessWidget {
  const OrderSlipSharePopup(this.files, {super.key});

  final List<File> files;

  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        scrollable: true,
        title: const Text('Order Slip'),
        content: SizedBox(
          width: min(400, context.width),
          child: Column(
            mainAxisSize: mainMin,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Your order ${files.length > 1 ? 'slips' : 'slip'} ',
                  style: context.text.labelLarge,
                  children: [
                    TextSpan(
                      text: '(total ${files.length})',
                      style: context.text.labelLarge!
                          .copyWith(color: context.theme.primaryColor),
                    ),
                    TextSpan(
                      text:
                          ' has been successfully downloaded. Do you want to share ${files.length > 1 ? 'those slips' : 'this slip'}?',
                      style: context.text.labelLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
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
            onPressed: () async {
              context.pop();
              await FileHandle.shareDocuments(files);
            },
            child: Text(
              'Share',
              style: TextStyle(color: context.theme.primaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              showAwesomeSnackbar(context, 'Message', 'Will update soon!', MessageType.warning);
            },
            child: Text(
              'Print',
              style: TextStyle(color: context.theme.primaryColor),
            ),
          ),
          TextButton(
            onPressed: () async {
              context.pop();
              return await FileHandle.openDocuments(files);
            },
            child: Text(
              'Open',
              style: TextStyle(color: context.theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
