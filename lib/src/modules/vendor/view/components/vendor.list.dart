import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/clipboard_data/clipboard_data.dart';
import '../../../../shared/error_widget/error_widget.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../shared/loading_widget/loading_widget.dart';
import '../../../../shared/page_not_found/page_not_found.dart';
import '../../../../shared/swipe.indicator/swipe.indicator.dart';
import '../../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../../utils/transations/fade.switcher.dart';
import '../../add/view/add.vendor.popup.dart';
import '../../delete/view/delete.vendor.popup.dart';
import '../../provider/vendor.provider.dart';

class VendorList extends ConsumerWidget {
  const VendorList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(vendorProvider);
    final notifier = ref.watch(vendorProvider.notifier);
    return Column(
      children: [
        TextFormField(
          controller: notifier.searchCntrlr,
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: ClearPrefixIcon(() => notifier.searchCntrlr.clear()),
            suffixIcon: PasteSuffixIcon(() async =>
                notifier.searchCntrlr.text = await getCliboardData()),
          ),
        ),
        Flexible(
          child: ref.watch(vendorProvider).when(
                loading: () => const LoadingWidget(withScaffold: false),
                error: (err, _) => KErrorWidget(error: err),
                data: (_) => FadeSwitcherTransition(
                  child: notifier.vendorList.isEmpty
                      ? const KDataNotFound(msg: 'No Vendor Found!')
                      : Column(
                          children: [
                            const SwipeIndicator(),
                            Flexible(
                              child: SlidableAutoCloseBehavior(
                                child: ListView.builder(
                                  itemCount: notifier.vendorList.length,
                                  itemBuilder: (_, idx) {
                                    final vendor = notifier.vendorList[idx];
                                    return Card(
                                      child: KListTile(
                                        key: ValueKey(vendor.id),
                                        onEditTap: () async => await showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (_) =>
                                              AddVendorPopup(vendor: vendor),
                                        ),
                                        onDeleteTap: () async =>
                                            await showDeleteVendorPopup(
                                                context, vendor),
                                        selected:
                                            notifier.selectedVendor == vendor,
                                        onTap: () =>
                                            notifier.selectVendor(vendor),
                                        onLongPress: () async =>
                                            await copyToClipboard(
                                                context, vendor.id),
                                        leading: AnimatedWidgetShower(
                                          size: 30.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: SvgPicture.asset(
                                              'assets/svgs/vendor.svg',
                                              colorFilter: context.theme
                                                  .primaryColor.toColorFilter,
                                              semanticsLabel: 'Vendor',
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          vendor.name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: context.text.titleSmall,
                                        ),
                                        subtitle: Text(
                                          vendor.address,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: context.text.labelSmall!
                                              .copyWith(
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                        trailing: const Icon(
                                            Icons.arrow_circle_right_outlined),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
        )
      ],
    );
  }
}
