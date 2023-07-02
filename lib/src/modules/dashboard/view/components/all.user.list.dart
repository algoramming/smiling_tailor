import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/clipboard_data/clipboard_data.dart';
import '../../../../shared/error_widget/error_widget.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../shared/loading_widget/loading_widget.dart';
import '../../../../shared/page_not_found/page_not_found.dart';
import '../../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../authentication/model/user.dart';
import '../../../transaction/api/trx.api.dart';
import '../../../transaction/enum/trx.type.dart';
import '../../../transaction/model/transaction.dart';
import '../../provider/all.users.provider.dart';

class AllUsersList extends ConsumerWidget {
  const AllUsersList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(allUsersProvider);
    final notifier = ref.watch(allUsersProvider.notifier);
    return Flexible(
      child: Column(
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
            child: ref.watch(allUsersProvider).when(
                  loading: () => const LoadingWidget(withScaffold: false),
                  error: (err, _) => KErrorWidget(error: err),
                  data: (_) => notifier.usersList.isEmpty
                      ? const KDataNotFound(msg: 'No User Found!')
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
                                  title: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          user.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      user.userTypeWidget,
                                    ],
                                  ),
                                  subtitle: Text(user.email),
                                  trailing: _UserListTrailing(user),
                                  children: [
                                    SizedBox(
                                      height: context.height * 0.5,
                                      child: _UserTrxList(user),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
          ),
        ],
      ),
    );
  }
}

class _UserTrxList extends ConsumerWidget {
  const _UserTrxList(this.user);

  final PktbsUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userTrxsProvider(user));
    final notifier = ref.watch(userTrxsProvider(user).notifier);
    return Column(
      children: [
        const SizedBox(height: 5.0),
        TextFormField(
          controller: notifier.searchCntrlr,
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: ClearPrefixIcon(() => notifier.searchCntrlr.clear()),
            suffixIcon: PasteSuffixIcon(() async =>
                notifier.searchCntrlr.text = await getCliboardData()),
          ),
        ),
        const SizedBox(height: 5.0),
        Flexible(
          child: ref.watch(userTrxsProvider(user)).when(
              loading: () => const LoadingWidget(withScaffold: false),
              error: (err, _) => KErrorWidget(error: err),
              data: (_) => notifier.trxList.isEmpty
                  ? const KDataNotFound(msg: 'No Transaction Found!')
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: notifier.trxList.length,
                      itemBuilder: (_, idx) {
                        final trx = notifier.trxList[idx];
                        final kColor =
                            trx.trxType.isCredit ? Colors.red : Colors.green;
                        return Card(
                          child: KListTile(
                            key: ValueKey(trx.id),
                            canEdit: false,
                            onDeleteTap: () async =>
                                await trxDeletePopup(context, trx),
                            onLongPress: () async =>
                                await copyToClipboard(context, trx.id),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 0.0),
                            leading: AnimatedWidgetShower(
                              padding: 3.0,
                              size: 35.0,
                              child: trx.modifiers,
                            ),
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: trx.fromName,
                                    style: context.text.titleSmall,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async =>
                                          await copyToClipboard(
                                              context, trx.fromId),
                                  ),
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6.0),
                                      child: RotatedBox(
                                        quarterTurns:
                                            trx.trxType.isDebit ? 0 : 1,
                                        child: Icon(
                                          Icons.arrow_outward_rounded,
                                          size: 16,
                                          color: kColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: trx.toName,
                                    style: context.text.titleSmall,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async =>
                                          await copyToClipboard(
                                              context, trx.toId),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: crossStart,
                              children: [
                                Text(
                                  trx.createdDate,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: context.text.labelMedium,
                                ),
                                if (trx.description != null)
                                  Tooltip(
                                    message: trx.description!,
                                    child: Text(
                                      trx.description!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: context.text.labelSmall!.copyWith(
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                              ],
                            ),
                            trailing: TweenAnimationBuilder(
                              curve: Curves.easeOut,
                              duration: kAnimationDuration(0.5),
                              tween: Tween<double>(begin: 0, end: trx.amount),
                              builder: (_, double x, __) {
                                return Tooltip(
                                  message: x.formattedFloat,
                                  child: Text(
                                    x.formattedCompat,
                                    style: context.text.labelLarge!.copyWith(
                                      color: kColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    )),
        )
      ],
    );
  }
}

class _UserListTrailing extends ConsumerWidget {
  const _UserListTrailing(this.user);

  final PktbsUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userTrxsProvider(user));
    final notifier = ref.watch(userTrxsProvider(user).notifier);
    final total = notifier.rawTrxsList.fold<double>(
      0.0,
      (p, c) => p + (c.trxType.isCredit ? -c.amount : c.amount),
    );
    final kColor = total.isNegative ? Colors.red : Colors.green;
    return TweenAnimationBuilder(
      curve: Curves.easeOut,
      duration: kAnimationDuration(0.5),
      tween: Tween<double>(begin: 0, end: total),
      builder: (_, double x, __) {
        return Tooltip(
          message: total.formattedFloat,
          child: Text(
            total.formattedCompat,
            style: context.text.labelLarge!.copyWith(color: kColor),
          ),
        );
      },
    );
  }
}
