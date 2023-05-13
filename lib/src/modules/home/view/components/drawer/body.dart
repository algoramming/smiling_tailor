import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smiling_tailor/src/modules/home/enum/home.enum.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../settings/view/basic/about.tile.dart';
import '../../../provider/home.provider.dart';

class KDrawerBody extends ConsumerWidget {
  const KDrawerBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);
    final info = ref.watch(infoProvider).value;
    final bn = info?.buildNumber == '0' ? '' : '(${info?.buildNumber})';
    return ListView(
      children: [
        ...List.generate(
          KDrawer.values.length,
          (index) => KListTile(
            selected: notifier.drawer == KDrawer.values[index],
            leading: AnimatedWidgetShower(
              size: 30.0,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  KDrawer.values[index].icon,
                  colorFilter: context.theme.primaryColor.toColorFilter,
                  semanticsLabel: KDrawer.values[index].title,
                ),
              ),
            ),
            title: Text(
              KDrawer.values[index].title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: KDrawer.values[index] == KDrawer.settings
                ? Text('Version ${info?.version}$bn')
                : null,
            onTap: () => notifier.changeDrawer(KDrawer.values[index]),
          ),
        ),
        // const SignoutTile(),
      ],
    );
  }
}
