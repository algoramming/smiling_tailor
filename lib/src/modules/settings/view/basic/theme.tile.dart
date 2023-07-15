import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../localization/loalization.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../model/theme/theme.model.dart';
import '../../provider/theme.provider.dart';

class ThemeTile extends ConsumerWidget {
  const ThemeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: SvgPicture.asset(
          'assets/svgs/theme.svg',
          colorFilter: context.theme.primaryColor.toColorFilter,
          semanticsLabel: 'Theme',
        ),
      ),
      title: Text(
        t.theme,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        theme == ThemeProfile.dark
            ? 'Switch to light theme'
            : 'Switch to dark theme',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Switch(
        value: theme == ThemeProfile.dark,
        onChanged: (_) async => ref.read(themeProvider.notifier).changeTheme(),
      ),
    );
  }
}
