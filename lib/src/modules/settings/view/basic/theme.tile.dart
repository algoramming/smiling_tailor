import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/constants.dart';
import '../../../../localization/loalization.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../model/theme/theme.model.dart';
import '../../provider/theme.provider.dart';

class ThemeTile extends StatelessWidget {
  const ThemeTile({super.key});

  @override
  Widget build(BuildContext context) {
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
      trailing: Row(
        crossAxisAlignment: crossStart,
        children: List.generate(
          ThemeProfile.values.length,
          (index) => Consumer(
            builder: (_, ref, __) {
              final theme = ref.watch(themeProvider);
              return InkWell(
                customBorder: roundedRectangleBorder30,
                onTap: theme == ThemeProfile.values[index]
                    ? null
                    : () async => await ref
                        .read(themeProvider.notifier)
                        .changeTheme(ThemeProfile.values[index]),
                child: Column(
                  mainAxisSize: mainMin,
                  mainAxisAlignment: mainCenter,
                  children: [
                    Container(
                      height: 25.0,
                      width: 25.0,
                      margin: const EdgeInsets.only(right: 3.0),
                      decoration: BoxDecoration(
                        color: ThemeProfile.values[index].color,
                        borderRadius: borderRadius30,
                        border: Border.all(
                          color: context.theme.primaryColor,
                          width: 2.5,
                        ),
                      ),
                    ),
                    if (theme == ThemeProfile.values[index])
                      Container(
                        height: 4.0,
                        width: 4.0,
                        margin: const EdgeInsets.only(top: 3.0, right: 3.0),
                        decoration: BoxDecoration(
                          color: context.theme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
