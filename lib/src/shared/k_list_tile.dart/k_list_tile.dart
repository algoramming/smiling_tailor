import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../utils/extensions/extensions.dart';

class KListTile extends StatelessWidget {
  const KListTile({
    super.key,
    this.onTap,
    this.title,
    this.leading,
    this.padding,
    this.trailing,
    this.subtitle,
    this.selected,
  });

  final Widget? title;
  final bool? selected;
  final Widget? leading;
  final Widget? subtitle;
  final Widget? trailing;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: context.theme.primaryColor.withOpacity(0.2),
      splashColor: context.theme.primaryColor.withOpacity(0.5),
      borderRadius: borderRadius15,
      radius: 30,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected == true
              ? context.theme.primaryColor.withOpacity(0.2)
              : null,
          borderRadius: borderRadius15,
        ),
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
          child: Row(
            mainAxisAlignment: mainCenter,
            children: [
              leading ?? const SizedBox.shrink(),
              const SizedBox(width: 10),
              Column(
                mainAxisSize: mainMin,
                crossAxisAlignment: crossStart,
                children: [
                  title ?? const SizedBox.shrink(),
                  if (subtitle != null) const SizedBox(height: 5),
                  subtitle ?? const SizedBox.shrink(),
                ],
              ),
              const Spacer(),
              trailing ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
