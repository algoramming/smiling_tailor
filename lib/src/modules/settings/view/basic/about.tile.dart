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
      onTap: () => showInfoDialog(context, '${info?.version}$bn'),
    );
  }
}

void showInfoDialog(BuildContext context, String version) => showAboutDialog(
      context: context,
      applicationName: 'Smiling Tailor',
      applicationVersion: version,
      applicationLegalese:
          '© 2023 Smiling Tailor (A product of Rahat\'s Corp.)',
      applicationIcon: Image.asset('assets/icons/splash-icon-384x384.png',
          height: 48, width: 48),
      children: [
        Text(
          '\nIntroducing our tailor-focused ERP management system - a powerful, user-friendly application designed to streamline your tailoring business. Add managers, vendors, inventory, and employees effortlessly. Seamlessly process orders and track transaction history in real-time. Stay organized, efficient, and in control with our comprehensive software solution. Proudly developed as an in-house product of Algoramming, ensuring quality and reliability in every aspect.',
          style: context.text.labelMedium,
          textAlign: TextAlign.justify,
        ),
        Text(
          '\n- Developed by Algoramming.',
          style: context.text.labelMedium!.copyWith(
            fontStyle: FontStyle.italic,
            color: context.theme.primaryColor,
          ),
          textAlign: TextAlign.right,
        )
      ],
    );
