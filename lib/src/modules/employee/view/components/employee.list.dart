import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/clipboard_data/clipboard_data.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../provider/employee.provider.dart';

class EmployeeList extends ConsumerWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(employeeProvider);
    final notifier = ref.watch(employeeProvider.notifier);
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
          child: notifier.employeeList.isEmpty
              ? const Center(child: Text('No employee found!'))
              : ListView.builder(
                  itemCount: notifier.employeeList.length,
                  itemBuilder: (_, idx) {
                    final employee = notifier.employeeList[idx];
                    return Card(
                      child: KListTile(
                        selected: notifier.selectedEmployee == employee,
                        onTap: () => notifier.selectEmployee(employee),
                        onLongPress: () async =>
                            await copyToClipboard(context, employee.id),
                        leading: AnimatedWidgetShower(
                          size: 30.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(
                              'assets/svgs/employee.svg',
                              colorFilter:
                                  context.theme.primaryColor.toColorFilter,
                              semanticsLabel: 'Employee',
                            ),
                          ),
                        ),
                        title: Text(employee.name),
                        subtitle: Text(employee.address),
                        trailing: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// class EmployeeList extends ConsumerWidget {
//   const EmployeeList({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.watch(employeeProvider);
//     final notifier = ref.watch(employeeProvider.notifier);
//     return NestedScrollView(
//       floatHeaderSlivers: true,
//       headerSliverBuilder: (_, __) => [
//         SliverToBoxAdapter(
//           child: TextFormField(
//             controller: notifier.searchCntrlr,
//             decoration: const InputDecoration(
//               hintText: 'Search...',
//               prefixIcon: Icon(Icons.search),
//             ),
//           ),
//         ),
//       ],
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             pinned: true,
//             floating: true,
//             leading: null,
//             title: TextFormField(
//               controller: notifier.searchCntrlr,
//               decoration: const InputDecoration(
//                 hintText: 'Search...',
//                 prefixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//           notifier.employeeList.isEmpty
//               ? const SliverToBoxAdapter(
//                   child: Center(child: Text('No employee found!')))
//               : SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     childCount: notifier.employeeList.length,
//                     (_, idx) {
//                       final employee = notifier.employeeList[idx];
//                       return Card(
//                         child: KListTile(
//                           selected: notifier.selectedEmployee == employee,
//                           onTap: () => notifier.selectEmployee(employee),
//                           leading: AnimatedWidgetShower(
//                             size: 30.0,
//                             child: Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: SvgPicture.asset(
//                                 'assets/svgs/employee.svg',
//                                 colorFilter:
//                                     context.theme.primaryColor.toColorFilter,
//                                 semanticsLabel: 'Employee',
//                               ),
//                             ),
//                           ),
//                           title: Text(employee.name),
//                           subtitle: Text(employee.address),
//                           trailing:
//                               const Icon(Icons.arrow_circle_right_outlined),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }
