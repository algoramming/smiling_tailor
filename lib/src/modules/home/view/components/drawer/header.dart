import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/settings/model/settings.model.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../../../../main.dart';
import '../../../../../constants/constants.dart';
import '../../../../../utils/logger/logger_helper.dart';
import '../../../../../utils/transations/big.to.small.dart';
import '../../../../authentication/model/user.dart';
import '../../../../authentication/provider/user.provider.dart';
import '../../../../settings/model/theme/theme.model.dart';

class KDrawerHeader extends ConsumerWidget {
  const KDrawerHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userProvider).value ?? [];
    final user = users.isEmpty ? null : users.last;
    log.i('User Rahat: $user');
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: context.theme.canvasColor),
      accountName: Text(user?.name ?? '...'),
      accountEmail: Text(user?.email ?? '...'),
      currentAccountPicture: Container(
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: context.theme.primaryColor, width: 2.0),
        ),
        child: ClipRRect(
          borderRadius: borderRadius45,
          child: FadeInImage(
            placeholder: const AssetImage('assets/gifs/loading.gif'),
            image: NetworkImage(
                user?.imageUrl ?? 'https://picsum.photos/250?image=9'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      otherAccountsPictures: [
        IconButton(
          icon: RotationTransition(
            turns: const AlwaysStoppedAnimation(45 / 360),
            child: BigToSmallTransition(
              child: appSettings.theme == ThemeProfile.light
                  ? const Icon(Icons.brightness_2)
                  : const Icon(Icons.brightness_7),
            ),
          ),
          onPressed: () async {
            appSettings.theme == ThemeProfile.light
                ? appSettings.theme = ThemeProfile.dark
                : appSettings.theme = ThemeProfile.light;
            await appSettings.save();
          },
        ),
      ],
    );
  }
}
