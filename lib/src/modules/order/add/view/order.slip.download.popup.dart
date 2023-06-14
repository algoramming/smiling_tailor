import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/constants.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/themes/themes.dart';

import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/clipboard_data/clipboard_data.dart';
import '../../../../shared/error_widget/error_widget.dart';
import '../../../../shared/loading_widget/loading_widget.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../model/order.dart';
import '../provider/order.slip.download.provider.dart';

Future<void> showOrderSlipDownloadPopup(
  BuildContext context,
  PktbsOrder order,
) async =>
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => OrderSlipDownloadPopup(order),
    );

class OrderSlipDownloadPopup extends StatelessWidget {
  const OrderSlipDownloadPopup(this.order, {super.key});

  final PktbsOrder order;

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
                      text: '#${order.id}',
                      style: context.text.labelLarge!
                          .copyWith(color: context.theme.primaryColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async =>
                            await copyToClipboard(context, order.id),
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
              _DownloadOptions(order),
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
          Consumer(
            builder: (_, ref, __) => TextButton(
              onPressed: () async {
                final notifier = ref.watch(orderSlipProvider(order).notifier);
                await notifier.submit().then((_) => context.pop());
              },
              child: Text(
                'Proceed',
                style: TextStyle(color: context.theme.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DownloadOptions extends ConsumerWidget {
  const _DownloadOptions(this.order);

  final PktbsOrder order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(orderSlipProvider(order)).when(
          loading: () =>
              const LoadingWidget(withScaffold: false, heightWidth: 100),
          error: (err, _) => KErrorWidget(withScaffold: false, error: err),
          data: (_) {
            final notifier = ref.watch(orderSlipProvider(order).notifier);
            return Column(
              children: [
                Text(
                  'Slip Copies',
                  style: context.text.titleMedium,
                ),
                const SizedBox(height: 10),
                ...List.generate(
                  notifier.slipOptions.length,
                  (i) => Card(
                    child: KListTile(
                      leading: Checkbox(
                        activeColor: context.theme.primaryColor,
                        value: notifier.selectedSlipOptions[i],
                        onChanged: (_) => notifier.toggleSlipOption(i),
                      ),
                      title: Text(notifier.slipOptions[i]['title']),
                      subtitle: Text(notifier.slipOptions[i]['subtitle']),
                      trailing: AnimatedWidgetShower(
                        size: 30.0,
                        child: Container(
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: borderRadius10,
                          ),
                          child: SvgPicture.asset(
                            notifier.slipOptions[i]['img'],
                            semanticsLabel: notifier.slipOptions[i]['title'],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Download Options',
                  style: context.text.titleMedium,
                ),
                const SizedBox(height: 10),
                ...List.generate(
                  notifier.downloadOptions.length,
                  (i) => Card(
                    child: KListTile(
                      leading: Checkbox(
                        activeColor: context.theme.primaryColor,
                        value: notifier.selectedDownloadOptions[i],
                        onChanged: (_) => notifier.toggleDownloadOption(i),
                      ),
                      title: Text(notifier.downloadOptions[i]['title']),
                      subtitle: Text(notifier.downloadOptions[i]['subtitle']),
                      trailing: AnimatedWidgetShower(
                        size: 30.0,
                        child: Container(
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: borderRadius10,
                          ),
                          child: SvgPicture.asset(
                            notifier.downloadOptions[i]['img'],
                            semanticsLabel: notifier.downloadOptions[i]
                                ['title'],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        );
  }
}
