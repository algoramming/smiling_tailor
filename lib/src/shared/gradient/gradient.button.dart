import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../utils/extensions/extensions.dart';
import '../../utils/themes/themes.dart';
import 'gradient.text.dart';

class GradientButton extends StatelessWidget {
  const GradientButton(
    this.label, {
    super.key,
    this.onTap,
    this.textStyle,
    this.stroke = 2.0,
    this.borderRadius,
    this.filled = false,
    this.gradient = defaultGradient,
    this.minSize = const Size(160.0, 40.0),
  });

  final bool filled;
  final Size minSize;
  final String label;
  final double stroke;
  final Gradient gradient;
  final TextStyle? textStyle;
  final void Function()? onTap;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: mainMin,
        children: [
          Container(
            constraints: BoxConstraints(
                minWidth: minSize.width, minHeight: minSize.height),
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? borderRadius5,
              gradient: defaultGradient,
            ),
            child: Center(
              child: Row(
                mainAxisSize: mainMin,
                children: [
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(
                          minWidth: minSize.width - stroke * 2,
                          minHeight: minSize.height - stroke * 2),
                      decoration: BoxDecoration(
                        borderRadius: borderRadius ?? borderRadius5,
                        color: filled ? white : transparent,
                      ),
                      child: filled
                          ? GradientText(
                              label,
                              gradient: defaultGradient,
                              style: textStyle ??
                                  context.text.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w700),
                            )
                          : Text(
                              label,
                              style: textStyle ??
                                  context.text.titleSmall!.copyWith(
                                    color: white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
