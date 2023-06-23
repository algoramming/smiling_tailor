import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';

import '../../../config/constants.dart';
import '../../../shared/animations_widget/animated_popup.dart';
import '../../../shared/clipboard_data/clipboard_data.dart';
import '../../../shared/error_widget/error_widget.dart';
import '../../../shared/loading_widget/loading_widget.dart';
import '../../../shared/page_not_found/page_not_found.dart';
import '../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../utils/extensions/extensions.dart';
import '../../order/add/pdf/file.handle.dart';
import '../provider/invoice.provider.dart';

class InvoiceView extends StatelessWidget {
  const InvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Consumer(builder: (_, ref, __) {
              final notifier = ref.watch(invoiceProvider.notifier);
              return TextFormField(
                controller: notifier.searchCntrlr,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon:
                      ClearPreffixIcon(() => notifier.searchCntrlr.clear()),
                  suffixIcon: PasteSuffixIcon(() async =>
                      notifier.searchCntrlr.text = await getCliboardData()),
                ),
              );
            }),
            const Expanded(child: _Body()),
          ],
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(invoiceProvider).when(
          loading: () => const LoadingWidget(withScaffold: false),
          error: (err, _) => KErrorWidget(error: err),
          data: (_) {
            final notifier = ref.watch(invoiceProvider.notifier);
            return notifier.fileList.isEmpty
                ? const KDataNotFound(msg: 'No Pdf Found!')
                : Column(
                    crossAxisAlignment: crossStart,
                    children: [
                      if (notifier.selectedFiles.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Row(
                            children: [
                              Transform.scale(
                                scale: 0.85,
                                child: Checkbox(
                                  activeColor: context.theme.primaryColor,
                                  value: notifier.isAllSelected,
                                  onChanged: (_) => notifier.toggleSelectAll(),
                                ),
                              ),
                              Text(
                                '${notifier.selectedFiles.length} selected',
                                style: context.text.labelLarge!.copyWith(
                                    color: context.theme.primaryColor),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () => notifier.toggleSelectingMode(),
                                icon: const Tooltip(
                                  message: 'Close',
                                  child: Icon(Icons.close, size: 20),
                                ),
                              ),
                              IconButton(
                                onPressed: () async =>
                                    await notifier.openSelectedFiles(),
                                icon: const Tooltip(
                                  message: 'Open',
                                  child: Icon(Icons.open_in_new, size: 20),
                                ),
                              ),
                              IconButton(
                                onPressed: () async =>
                                    await notifier.shareSelectedFiles(),
                                icon: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(pi),
                                  child: const Tooltip(
                                    message: 'Share',
                                    child: Icon(Icons.reply, size: 20),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async => await showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => const DeleteInvoicesPopup(),
                                ),
                                icon: const Tooltip(
                                  message: 'Delete',
                                  child: Icon(Icons.delete, size: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 3.0, 5.0, 0.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '... total ${notifier.rawFiles.length} files',
                            style: context.text.labelMedium!
                                .copyWith(color: context.theme.primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: SingleChildScrollView(
                            child: Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              children: [
                                for (final file in [...notifier.fileList])
                                  InkWell(
                                    borderRadius: borderRadius10,
                                    onTap: () async {
                                      if (notifier.isSelectingMode) {
                                        notifier.toggleFileSelection(file);
                                        return;
                                      } else {
                                        await FileHandle.openDocument(file);
                                        return;
                                      }
                                    },
                                    onLongPress: () {
                                      if (!notifier.isSelectingMode) {
                                        notifier.toggleSelectingMode();
                                      }
                                      notifier.toggleFileSelection(file);
                                    },
                                    child: Card(
                                      shape: roundedRectangleBorder10,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        width: 120,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: notifier.isSelected(file)
                                                ? context.theme.primaryColor
                                                : context.theme.dividerColor,
                                          ),
                                          borderRadius: borderRadius10,
                                        ),
                                        child: Column(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svgs/pdf-format.svg',
                                              semanticsLabel: 'Invoice',
                                              fit: BoxFit.fill,
                                              height: 95.0,
                                              width: 110.0,
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              basename(file.path),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: context.text.labelSmall!
                                                  .copyWith(
                                                color: notifier.isSelected(file)
                                                    ? context.theme.primaryColor
                                                    : null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          },
        );
  }
}

class DeleteInvoicesPopup extends ConsumerWidget {
  const DeleteInvoicesPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(invoiceProvider.notifier);
    return AnimatedPopup(
      child: AlertDialog(
        title: const Text('Warning'),
        content: SizedBox(
          width: min(context.width * 0.8, 400.0),
          child: const Text(
              'Are you sure you want to delete selected Invoices? This will delete all your invoices and this action is irreversible.'),
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
            onPressed: () async =>
                await notifier.deleteSelectedFiles().then((_) {
              ref.invalidate(invoiceProvider);
              context.pop();
            }),
            child: const Text(
              'DELETE',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
