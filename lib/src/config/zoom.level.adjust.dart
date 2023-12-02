import 'package:flutter/material.dart';

import '../utils/extensions/extensions.dart';

class ZoomLevelAdjustWarning extends StatelessWidget {
  const ZoomLevelAdjustWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Please reset your PC\'s zoom level to the default setting of 100%. Use the Ctrl/Cmd key in combination with the "+" or "-" keys to adjust the zoom level accordingly.',
          textScaler: const TextScaler.linear(1.5),
          textAlign: TextAlign.center,
          style: context.text.labelLarge!
              .copyWith(color: context.theme.dividerColor),
        ),
      ),
    );
  }
}
