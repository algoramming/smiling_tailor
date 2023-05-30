import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../localization/loalization.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';

final infoProvider =
    FutureProvider((_) async => await PackageInfo.fromPlatform());

class AboutTile extends ConsumerWidget {
  const AboutTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(infoProvider).value;
    final bn = info?.buildNumber == '0' ? '' : '(${info?.buildNumber})';
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: SvgPicture.asset(
          'assets/svgs/about.svg',
          colorFilter: context.theme.primaryColor.toColorFilter,
          semanticsLabel: 'About',
        ),
      ),
      title: Text(
        t.about,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: info == null ? null : Text('${t.appTitle} ${info.version}$bn'),
      onTap: () => showInfoDialog(context),
    );
  }
}

void showInfoDialog(BuildContext context) => showAboutDialog(
      context: context,
      applicationName: 'Smiling Tailor',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2023 Smiling Tailor',
      applicationIcon: Image.asset('assets/icons/splash-icon-384x384.png',
          height: 48, width: 48),
      children: const [
        Text(
            'A simple app to manage your tailoring business developed by Algoramming.'),
      ],
    );
