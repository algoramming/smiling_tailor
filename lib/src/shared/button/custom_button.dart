import 'package:flutter/material.dart';

class KCustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final double? radius;

  const KCustomButton(
      {Key? key,
      required this.child,
      required this.onTap,
      this.radius,
      this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 50),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius ?? 50),
        child: InkWell(
          splashColor: Theme.of(context).primaryColorDark.withOpacity(.2),
          highlightColor: Theme.of(context).primaryColorDark.withOpacity(.05),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Center(child: child),
        ),
      ),
    );
  }
}
