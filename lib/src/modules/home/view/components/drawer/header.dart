import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/config/constants.dart';

import '../../../../../utils/extensions/extensions.dart';
import '../../../../authentication/model/user.dart';
import '../../../../authentication/provider/user.provider.dart';

class KDrawerHeader extends ConsumerWidget {
  const KDrawerHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userProvider).value ?? [];
    final user = users.isEmpty ? null : users.last;
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: context.theme.canvasColor),
      accountName: Row(
        children: [
          Flexible(child: Text(user?.name ?? '...')),
          if (user != null)
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: user.type.color.withOpacity(0.3),
                    borderRadius: borderRadius30,
                    border: Border.all(color: user.type.color, width: 1.5),
                  ),
                  child: Text(
                    user.type.title,
                    style: context.text.labelSmall,
                  ),
                ),
              ],
            ),
        ],
      ),
      accountEmail: Text(user?.email ?? '...'),
      currentAccountPicture: user?.imageWidget,
      // otherAccountsPictures: [
      //   IconButton(
      //     icon: RotationTransition(
      //       turns: const AlwaysStoppedAnimation(45 / 360),
      //       child: BigToSmallTransition(
      //         child: appSettings.theme == ThemeProfile.dark
      //             ? const Icon(Icons.brightness_7)
      //             : const Icon(Icons.brightness_2),
      //       ),
      //     ),
      //     onPressed: () async {
      //       appSettings.theme == ThemeProfile.light
      //           ? appSettings.theme = ThemeProfile.dark
      //           : appSettings.theme = ThemeProfile.light;
      //       await appSettings.save();
      //     },
      //   ),
      // ],
    );
  }
}
