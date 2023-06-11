import 'package:flutter/material.dart';

import '../../db/isar.dart';
import '../../utils/extensions/extensions.dart';
import '../animations_widget/animated_widget_shower.dart';

class KSuffixIcon extends StatelessWidget {
  const KSuffixIcon({this.text, super.key});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgetShower(
      size: 28.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
        child: Center(
          child: Text(
            text ?? appCurrency.symbol,
            style: context.text.labelLarge,
          ),
        ),
      ),
    );
  }
}
