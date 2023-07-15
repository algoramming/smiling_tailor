import 'package:flutter/material.dart';

import '../../utils/themes/themes.dart';

class GradientWidget extends StatelessWidget {
  const GradientWidget({
    required this.child,
    super.key,
    this.gradient,
  });

  final Widget child;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => (gradient ?? defaultGradient).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: child,
    );
  }
}
