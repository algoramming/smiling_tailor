import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/authentication/model/user.dart';

import '../../../shared/loading_widget/loading_widget.dart';
import '../../../shared/page_not_found/page_not_found.dart';
import '../../../utils/themes/themes.dart';
import '../../../utils/transations/big.to.small.dart';
import '../../profile/provider/profile.provider.dart';
import '../add/view/add.employee.popup.dart';
import '../provider/employee.provider.dart';
import 'components/employee.details.dart';
import 'components/employee.list.dart';

class EmployeeView extends ConsumerWidget {
  const EmployeeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileProvider);
    if (user == null) return const LoadingWidget();
    if (user.isDispose || user.isManager) return const AccesDeniedPage();
    return Scaffold(
      body: const SafeArea(
        child: Row(
          children: [
            Expanded(flex: 3, child: EmployeeList()),
            SizedBox(width: 6.0),
            Expanded(flex: 5, child: EmployeeDetails()),
          ],
        ),
      ),
      floatingActionButton: Consumer(
        builder: (_, ref, __) {
          ref.watch(employeeProvider);
          final notifier =
              ref.watch(employeeProvider.notifier).selectedEmployee;
          return BigToSmallTransition(
            child: notifier != null
                ? const SizedBox.shrink()
                : FloatingActionButton.small(
                    tooltip: 'Add Employee',
                    onPressed: () async => await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => const AddEmployeePopup(),
                    ),
                    child: const Icon(Icons.add, color: white),
                  ),
          );
        },
      ),
    );
  }
}
