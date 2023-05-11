import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../localization/loalization.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';

class DBViewTile extends StatelessWidget {
  const DBViewTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(
            'assets/svgs/db-view.svg',
            colorFilter: context.theme.primaryColor.toColorFilter,
            semanticsLabel: 'Delete Database',
          ),
        ),
      ),
      title: Text(
        t.viewDatabase,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () async {},
    );
  }
}
