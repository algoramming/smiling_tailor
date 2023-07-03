import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/authentication/model/user.dart';
import 'package:smiling_tailor/src/shared/k_list_tile.dart/k_list_tile.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../shared/clipboard_data/clipboard_data.dart';
import '../../../shared/error_widget/error_widget.dart';
import '../../../shared/loading_widget/loading_widget.dart';
import '../../../shared/page_not_found/page_not_found.dart';
import '../../../shared/textfield.suffix.widget/suffix.widget.dart';
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
                            child: KListTile(
                              onLongPress: () async =>
                                  await copyToClipboard(context, user.id),
                              leading: AnimatedWidgetShower(
                                size: 30.0,
                                child: user.imageWidget,
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    user.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: context.text.titleSmall,
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                user.email,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: context.text.labelSmall!
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                              trailing: user.userTypeWidget,
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
