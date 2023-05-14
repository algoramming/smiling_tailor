import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smiling_tailor/src/modules/vendor/provider/vendor.provider.dart';

import '../../../../constants/constants.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';

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
          decoration: const InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search),
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
                        leading: Container(
                          height: 45.0,
                          width: 45.0,
                          padding: const EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: context.theme.primaryColor, width: 1.3),
                          ),
                          child: ClipRRect(
                            borderRadius: borderRadius45,
                            child: SvgPicture.asset(
                              'assets/svgs/vendor.svg',
                              fit: BoxFit.cover,
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
