import 'package:flutter/material.dart';

import '../utils/extensions/extensions.dart';

class ScreenEnlargeWarning extends StatelessWidget {
  const ScreenEnlargeWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Please enlarge your application window.',
          textScaler: const TextScaler.linear(1.5),
          textAlign: TextAlign.center,
          style: context.text.labelLarge!
              .copyWith(color: context.theme.dividerColor),
        ),
      ),
    );
  }
}
