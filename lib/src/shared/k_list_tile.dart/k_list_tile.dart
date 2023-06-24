import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../config/constants.dart';
import '../../utils/extensions/extensions.dart';
import '../../utils/themes/themes.dart';

class KListTile extends StatelessWidget {
  const KListTile({
    Key? key,
    this.onTap,
    this.title,
    this.leading,
    this.padding,
    this.trailing,
    this.subtitle,
    this.selected,
    this.onEditTap,
    this.onDeleteTap,
    this.onDoubleTap,
    this.onLongPress,
    this.slidableAction,
    this.canEdit = true,
    this.paddingBetweenTitleAndSubtitle,
  }) : super(key: key);

  final bool canEdit;
  final Widget? title;
  final bool? selected;
  final Widget? leading;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? slidableAction;
  final void Function()? onTap;
  final void Function()? onEditTap;
  final EdgeInsetsGeometry? padding;
  final void Function()? onDeleteTap;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;
  final double? paddingBetweenTitleAndSubtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: context.theme.primaryColor.withOpacity(0.2),
      splashColor: context.theme.primaryColor.withOpacity(0.5),
      borderRadius: borderRadius12,
      radius: 30,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: key == null
          ? _Tile(
              selected: selected,
              padding: padding,
              leading: leading,
              title: title,
              subtitle: subtitle,
              paddingBetweenTitleAndSubtitle: paddingBetweenTitleAndSubtitle,
              trailing: trailing,
            )
          : Slidable(
              key: key!,
              startActionPane: ActionPane(
                motion: const StretchMotion(),
                extentRatio: slidableAction != null
                    ? canEdit
                        ? 0.45
                        : 0.3
                    : canEdit
                        ? 0.3
                        : 0.15,
                children: [
                  if (slidableAction != null) slidableAction!,
                  if (canEdit)
                    Theme(
                      data: context.theme.copyWith(
                        iconTheme: context.theme.iconTheme.copyWith(size: 20.0),
                      ),
                      child: SlidableAction(
                        borderRadius: borderRadius15,
                        onPressed: (_) => onEditTap?.call(),
                        backgroundColor: Colors.grey[600]!,
                        foregroundColor: white,
                        icon: Icons.edit_outlined,
                        label: 'Edit',
                        padding: EdgeInsets.zero,
                        autoClose: true,
                      ),
                    ),
                  Theme(
                    data: context.theme.copyWith(
                      iconTheme: context.theme.iconTheme.copyWith(size: 20.0),
                    ),
                    child: SlidableAction(
                      borderRadius: borderRadius15,
                      onPressed: (_) => onDeleteTap?.call(),
                      backgroundColor: Colors.red[400]!,
                      foregroundColor: white,
                      icon: Icons.delete,
                      label: 'Delete',
                      padding: EdgeInsets.zero,
                      autoClose: true,
                    ),
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                extentRatio: slidableAction != null
                    ? canEdit
                        ? 0.45
                        : 0.3
                    : canEdit
                        ? 0.3
                        : 0.15,
                children: [
                  Theme(
                    data: context.theme.copyWith(
                      iconTheme: context.theme.iconTheme.copyWith(size: 20.0),
                    ),
                    child: SlidableAction(
                      borderRadius: borderRadius15,
                      onPressed: (_) => onDeleteTap?.call(),
                      backgroundColor: Colors.red[400]!,
                      foregroundColor: white,
                      icon: Icons.delete,
                      label: 'Delete',
                      padding: EdgeInsets.zero,
                      autoClose: true,
                    ),
                  ),
                  if (canEdit)
                    Theme(
                      data: context.theme.copyWith(
                        iconTheme: context.theme.iconTheme.copyWith(size: 20.0),
                      ),
                      child: SlidableAction(
                        borderRadius: borderRadius15,
                        onPressed: (_) => onEditTap?.call(),
                        backgroundColor: Colors.grey[600]!,
                        foregroundColor: white,
                        icon: Icons.edit_outlined,
                        label: 'Edit',
                        padding: EdgeInsets.zero,
                        autoClose: true,
                      ),
                    ),
                  if (slidableAction != null) slidableAction!,
                ],
              ),
              child: _Tile(
                selected: selected,
                padding: padding,
                leading: leading,
                title: title,
                subtitle: subtitle,
                paddingBetweenTitleAndSubtitle: paddingBetweenTitleAndSubtitle,
                trailing: trailing,
              ),
            ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.selected,
    required this.padding,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.paddingBetweenTitleAndSubtitle,
    required this.trailing,
  });

  final bool? selected;
  final EdgeInsetsGeometry? padding;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final double? paddingBetweenTitleAndSubtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Expanded(
              flex: 9,
              child: Column(
                mainAxisSize: mainMin,
                crossAxisAlignment: crossStart,
                children: [
                  title ?? const SizedBox.shrink(),
                  if (subtitle != null)
                    SizedBox(height: paddingBetweenTitleAndSubtitle ?? 2.0),
                  subtitle ?? const SizedBox.shrink(),
                ],
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
