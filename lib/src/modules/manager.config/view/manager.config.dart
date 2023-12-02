import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../config/constants.dart';
import '../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../shared/clipboard_data/clipboard_data.dart';
import '../../../shared/error_widget/error_widget.dart';
import '../../../shared/gradient/gradient.button.dart';
import '../../../shared/loading_widget/loading_widget.dart';
import '../../../shared/page_not_found/page_not_found.dart';
import '../../../shared/radio_button/k_radio_button.dart';
import '../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../utils/themes/themes.dart';
import '../../authentication/model/user.dart';
import '../../authentication/model/user.type.enum.dart';
import '../../authentication/view/authentication.dart';
import '../../dashboard/provider/all.users.provider.dart';
import '../../profile/provider/profile.provider.dart';
import '../provider/all.managers.provider.dart';

class ManagerConfigView extends ConsumerWidget {
  const ManagerConfigView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileProvider);
    if (user == null) return const LoadingWidget();
    if (user.isDispose || user.isNotAdmin) return const AccesDeniedPage();
    return const Row(
      children: [
        Expanded(child: AllManagersList()),
        Expanded(child: AuthenticationView(isSignup: true)),
      ],
    );
  }
}

class AllManagersList extends ConsumerWidget {
  const AllManagersList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(allUsersProvider);
    ref.watch(allManagersProvider);
    final notifier = ref.watch(allManagersProvider.notifier);
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
          child: ref.watch(allManagersProvider).when(
                loading: () => const LoadingWidget(withScaffold: false),
                error: (err, _) => KErrorWidget(error: err),
                data: (_) => notifier.usersList.isEmpty
                    ? const KDataNotFound(msg: 'No Manager Found!')
                    : ListView.builder(
                        itemCount: notifier.usersList.length,
                        itemBuilder: (_, idx) {
                          final user = notifier.usersList[idx];
                          return Card(
                            child: InkWell(
                              onLongPress: () async =>
                                  await copyToClipboard(context, user.id),
                              child: ExpansionTile(
                                leading: AnimatedWidgetShower(
                                  size: 30.0,
                                  child: user.imageWidget,
                                ),
                                title: Text(
                                  user.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: context.text.titleSmall,
                                ),
                                subtitle: Text(
                                  user.email,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: context.text.labelSmall!
                                      .copyWith(fontWeight: FontWeight.normal),
                                ),
                                trailing: user.userTypeWidget,
                                children: [
                                  _Children(user: user),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
        ),
      ],
    );
  }
}

class _Children extends ConsumerWidget {
  const _Children({required this.user});

  final PktbsUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(managerProvider(user));
    final notifier = ref.watch(managerProvider(user).notifier);
    return Column(
      mainAxisSize: mainMin,
      children: [
        const SizedBox(height: 10.0),
        Text(
          'Change User Type',
          style: context.text.titleMedium,
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: mainSpaceEvenly,
          children: List.generate(
            UserType.values.length,
            (idx) => KRadioButton(
              value: idx,
              label: UserType.values[idx].title,
              groupValue: notifier.userType,
              onTap: () => notifier.changeUserType(idx),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        if (notifier.showUpdateButton)
          GradientButton(
            'Update',
            minSize: const Size(120.0, 30.0),
            textStyle: context.text.labelMedium!.copyWith(color: white),
            borderRadius: borderRadius30,
            onTap: () async => await notifier.updateRole(context),
          ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
