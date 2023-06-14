import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smiling_tailor/src/config/constants.dart';
import 'package:smiling_tailor/src/shared/k_list_tile.dart/k_list_tile.dart';
import 'package:smiling_tailor/src/utils/themes/themes.dart';

import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
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
              const SizedBox(height: 20),
              Card(
                child: KListTile(
                  trailing: AnimatedWidgetShower(
                    size: 30.0,
                    child: Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: borderRadius10,
                      ),
                      child: SvgPicture.asset(
                        'assets/svgs/customer-copy.svg',
                        // colorFilter: context.theme.primaryColor.toColorFilter,
                        semanticsLabel: 'Inventory',
                      ),
                    ),
                  ),
                  title: const Text('Customer Copy'),
                  subtitle: const Text('This copy is for customer.'),
                  // trailing: const Icon(Icons.arrow_circle_right_outlined),
                ),
              ),
              Card(
                child: KListTile(
                  trailing: AnimatedWidgetShower(
                    size: 30.0,
                    child: Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: borderRadius10,
                      ),
                      child: SvgPicture.asset(
                        'assets/svgs/cashier-copy.svg',
                        // colorFilter: context.theme.primaryColor.toColorFilter,
                        semanticsLabel: 'Inventory',
                      ),
                    ),
                  ),
                  title: const Text('Cashier Copy'),
                  subtitle: const Text('This copy is for cashier.'),
                  // trailing: const Icon(Icons.arrow_circle_right_outlined),
                ),
              ),
              Card(
                child: KListTile(
                  trailing: AnimatedWidgetShower(
                    size: 30.0,
                    child: Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: borderRadius10,
                      ),
                      child: SvgPicture.asset(
                        'assets/svgs/tailor-copy.svg',
                        // colorFilter: context.theme.primaryColor.toColorFilter,
                        semanticsLabel: 'Inventory',
                      ),
                    ),
                  ),
                  title: const Text('Tailor Copy'),
                  subtitle: const Text('This copy is for tailor.'),
                  // trailing: const Icon(Icons.arrow_circle_right_outlined),
                ),
              ),
              Card(
                child: KListTile(
                  trailing: AnimatedWidgetShower(
                    size: 30.0,
                    child: Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: borderRadius10,
                      ),
                      child: SvgPicture.asset(
                        'assets/svgs/pdf-format.svg',
                        // colorFilter: context.theme.primaryColor.toColorFilter,
                        semanticsLabel: 'Inventory',
                      ),
                    ),
                  ),
                  title: const Text('Pdf Format'),
                  subtitle: const Text('Printable pdf format.'),
                  // trailing: const Icon(Icons.arrow_circle_right_outlined),
                ),
              ),
              Card(
                child: KListTile(
                  trailing: AnimatedWidgetShower(
                    size: 30.0,
                    child: Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: borderRadius10,
                      ),
                      child: SvgPicture.asset(
                        'assets/svgs/slip-format.svg',
                        // colorFilter: context.theme.primaryColor.toColorFilter,
                        semanticsLabel: 'Inventory',
                      ),
                    ),
                  ),
                  title: const Text('Slip Format'),
                  subtitle: const Text('Printable slip format.'),
                  // trailing: const Icon(Icons.arrow_circle_right_outlined),
                ),
              ),
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
