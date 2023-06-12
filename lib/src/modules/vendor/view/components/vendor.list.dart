import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smiling_tailor/src/shared/textfield.suffix.widget/suffix.widget.dart';

import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/clipboard_data/clipboard_data.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';
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
            prefixIcon: ClearPreffixIcon(() => notifier.searchCntrlr.clear()),
            suffixIcon: PasteSuffixIcon(() async =>
                notifier.searchCntrlr.text = await getCliboardData()),
          ),
        ),
        Flexible(
          child: notifier.vendorList.isEmpty
              ? const Center(child: Text('No vendor found!'))
              : ListView.builder(
                  itemCount: notifier.vendorList.length,
                  itemBuilder: ((_, idx) {
                    final vendor = notifier.vendorList[idx];
                    return Card(
                      child: KListTile(
                        selected: notifier.selectedVendor == vendor,
                        onTap: () => notifier.selectVendor(vendor),
                        onLongPress: () async =>
                            await copyToClipboard(context, vendor.id),
                        leading: AnimatedWidgetShower(
                          size: 30.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(
                              'assets/svgs/vendor.svg',
                              colorFilter:
                                  context.theme.primaryColor.toColorFilter,
                              semanticsLabel: 'Vendor',
                            ),
                          ),
                        ),
                        title: Text(vendor.name),
                        subtitle: Text(vendor.address),
                        trailing: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    );
                  }),
                ),
        )
      ],
    );
  }
}
