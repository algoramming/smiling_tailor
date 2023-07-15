import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/constants.dart';
import '../../utils/extensions/extensions.dart';

class SwipeIndicator extends StatelessWidget {
  const SwipeIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainCenter,
      children: [
        SvgPicture.asset(
          'assets/svgs/left-arrow.svg',
          colorFilter: context.theme.dividerColor.toColorFilter,
          height: 20.0,
          width: 50.0,
          fit: BoxFit.fitWidth,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Swipe to see more options',
            style: context.text.labelSmall!.copyWith(
              color: context.theme.dividerColor,
            ),
          ),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: SvgPicture.asset(
            'assets/svgs/left-arrow.svg',
            colorFilter: context.theme.dividerColor.toColorFilter,
            height: 20.0,
            width: 55.0,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }
}
