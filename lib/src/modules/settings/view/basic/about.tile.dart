import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../config/constants.dart';
import '../../../../localization/loalization.dart';
import '../../../../shared/animations_widget/animated_popup.dart';
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
      onTap: () async => await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => KAboutDialog('${info?.version}$bn'),
      ),
    );
  }
}

class KAboutDialog extends StatelessWidget {
  const KAboutDialog(this.version, {super.key});

  final String version;

  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        title: Row(
          children: [
            Image.asset(
              'assets/icons/splash-icon-384x384.png',
              height: 52,
              width: 52,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: crossStart,
              children: [
                Text(
                  'Smiling Tailor',
                  style: context.text.titleLarge,
                ),
                const SizedBox(height: 2),
                Text(
                  version,
                  style: context.text.labelMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '© 2023 Smiling Tailor (A product of Rahat Corp.)',
                  style: context.text.labelMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            )
          ],
        ),
        content: SizedBox(
          width: min(400, context.width),
          child: Column(
            mainAxisSize: mainMin,
            children: [
              Text(
                '\nWelcome to our tailor-centric Custom Business Management System, where the dynamic fusion of ERP (Enterprise Resource Planning) and CRM (Customer Relationship Management) empowers your tailoring business like never before. Our feature-rich and user-friendly application has been meticulously crafted to streamline your operations effortlessly. With our cutting-edge system, you can easily manage and monitor essential elements of your business, including managers, vendors, inventory, and employees. Effortlessly process orders and witness the seamless flow of transaction history in real-time, ensuring airtight organization, enhanced efficiency, and complete control over your business processes. We take pride in presenting this exceptional software solution, developed in-house by our skilled team at Algoramming. Our commitment to quality and reliability ensures that every aspect of our system is fine-tuned to meet the specific needs of your tailoring business, setting you on a path to success with unparalleled ease.',
                style: context.text.labelMedium,
                textAlign: TextAlign.justify,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '\n- Algoramming.',
                  style: context.text.labelMedium!.copyWith(
                    color: context.theme.primaryColor,
                  ),
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style:
                  TextStyle(color: context.theme.dividerColor.withOpacity(0.8)),
            ),
          ),
          TextButton(
            onPressed: () => showLicensePage(context: context),
            child: Text(
              'View licenses',
              style: TextStyle(color: context.theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
