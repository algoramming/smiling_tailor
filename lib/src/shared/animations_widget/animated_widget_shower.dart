import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../utils/extensions/extensions.dart';

class AnimatedWidgetShower extends StatelessWidget {
  const AnimatedWidgetShower({
    super.key,
    required this.child,
    required this.size,
  });

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: roundedRectangleBorder15,
      color: context.theme.primaryColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height: size,
          width: size,
          child: TweenAnimationBuilder(
            curve: Curves.easeOut,
            duration: kAnimationDuration(0.4),
            tween: Tween<double>(begin: 0, end: size),
            builder: (_, double x, __) {
              return Center(
                child: SizedBox(
                  height: x,
                  width: x,
                  child: child,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
