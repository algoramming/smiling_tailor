import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../pocketbase/auth.store/helpers.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';

class AdminPanelTile extends StatelessWidget {
  const AdminPanelTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(
            'assets/svgs/transaction.svg',
            colorFilter: context.theme.primaryColor.toColorFilter,
            semanticsLabel: 'Admin Panel',
          ),
        ),
      ),
      title: const Text(
        'Admin Panel',
        textAlign: TextAlign.justify,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () async {
        final uri = Uri.parse('${baseUrl}_/');
        if (!await launchUrl(uri)) {
          throw 'Could not launch';
        }
      },
    );
  }
}
