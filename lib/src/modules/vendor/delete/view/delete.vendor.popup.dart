import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/transaction/enum/trx.type.dart';
import 'package:smiling_tailor/src/modules/transaction/model/transaction.dart';
import 'package:smiling_tailor/src/shared/animations_widget/animated_popup.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../../config/constants.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/clipboard_data/clipboard_data.dart';
import '../../../../shared/error_widget/error_widget.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../shared/loading_widget/loading_widget.dart';
import '../../model/vendor.dart';
import '../provider/delete.vendor.provider.dart';

Future<void> showDeleteVendorPopup(
    BuildContext context, PktbsVendor vendor) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => DeleteVendorPopup(vendor),
  );
}

class DeleteVendorPopup extends StatelessWidget {
  const DeleteVendorPopup(this.vendor, {super.key});

  final PktbsVendor vendor;

  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        scrollable: true,
        title: const Text('Delete Vendor'),
        content: _Content(vendor),
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
              onPressed: () async => await ref
                  .read(deleteVendorProvider(vendor).notifier)
                  .submit(context),
              child: const Text(
                'Delete Vendor',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content(this.vendor);

  final PktbsVendor vendor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(deleteVendorProvider(vendor).notifier);
    return SizedBox(
      width: min(400, context.width),
      child: ref.watch(deleteVendorProvider(vendor)).when(
            loading: () => const LoadingWidget(withScaffold: false),
            error: (err, _) => KErrorWidget(error: err),
            data: (_) => Column(
              children: [
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Are you sure you want to delete this vendor ',
                        style: context.text.labelLarge,
                      ),
                      TextSpan(
                        text: '${notifier.arg.name} (#${notifier.arg.id})',
                        style: context.text.labelLarge!.copyWith(
                          color: context.theme.primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: ' ?  ',
                        style: context.text.labelLarge,
                      ),
                      TextSpan(
                        text:
                            'This will also delete all transactions related to this vendor and this action cannot be undone. So please be careful & make sure you want to delete this vendor.',
                        style: context.text.labelLarge!.copyWith(
                          color: Colors.red,
                        ),
                      ),
                      TextSpan(
                        text:
                            '\n**Strongly recommended not to delete any kind of general leaguers.**',
                        style: context.text.labelLarge!.copyWith(
                          color: context.theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                if (notifier.trxs.isEmpty) ...[
                  const SizedBox(height: 20.0),
                  Text(
                    'This employee has no transactions.',
                    style: context.text.labelMedium,
                  ),
                  const SizedBox(height: 20.0),
                ],
                if (notifier.trxs.isNotEmpty)
                  ...List.generate(
                    notifier.trxs.length,
                    (i) {
                      final trx = notifier.trxs[i];
                      final kColor =
                          trx.trxType.isCredit ? Colors.red : Colors.green;
                      return Card(
                        child: KListTile(
                          onTap: () => notifier.toggleSelected(i),
                          isSystemGenerated: trx.isSystemGenerated,
                          onLongPress: () async =>
                              await copyToClipboard(context, trx.id),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 5.0),
                          leading: AnimatedWidgetShower(
                            padding: 3.0,
                            size: 35.0,
                            child: Transform.scale(
                              scale: 0.85,
                              child: Checkbox(
                                activeColor: context.theme.primaryColor,
                                value: notifier.isSelected(i),
                                onChanged: (_) => notifier.toggleSelected(i),
                              ),
                            ),
                          ),
                          title: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: trx.fromName,
                                  style: context.text.labelMedium,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async => await copyToClipboard(
                                        context, trx.fromId),
                                ),
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    child: RotatedBox(
                                      quarterTurns: trx.trxType.isDebit ? 0 : 1,
                                      child: Icon(
                                        Icons.arrow_outward_rounded,
                                        size: 13,
                                        color: kColor,
                                      ),
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: trx.toName,
                                  style: context.text.labelMedium,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async => await copyToClipboard(
                                        context, trx.toId),
                                ),
                              ],
                            ),
                          ),
                          subtitle: trx.description == null
                              ? null
                              : Text(
                                  trx.description!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: context.text.labelSmall!
                                      .copyWith(fontWeight: FontWeight.normal),
                                ),
                          trailing: TweenAnimationBuilder(
                            curve: Curves.easeOut,
                            duration: kAnimationDuration(0.5),
                            tween: Tween<double>(begin: 0, end: trx.amount),
                            builder: (_, double x, __) => Tooltip(
                              message: x.formattedFloat,
                              child: Text(
                                x.formattedCompat,
                                style: context.text.labelMedium!
                                    .copyWith(color: kColor),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
    );
  }
}
