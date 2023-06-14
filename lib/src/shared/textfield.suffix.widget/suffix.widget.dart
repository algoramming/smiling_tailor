import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../db/isar.dart';
import '../../utils/extensions/extensions.dart';
import '../animations_widget/animated_widget_shower.dart';

class CurrencySuffixIcon extends StatelessWidget {
  const CurrencySuffixIcon({this.text, super.key});

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

class PasteSuffixIcon extends StatelessWidget {
  const PasteSuffixIcon(this.onTap, {super.key});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgetShower(
      size: 28.0,
      child: InkWell(
        borderRadius: borderRadius10,
        onTap: onTap,
        child: const Icon(
          Icons.content_paste_go_outlined,
          size: 20.0,
        ),
      ),
    );
  }
}

class ClearPreffixIcon extends StatelessWidget {
  const ClearPreffixIcon(this.onTap, {super.key});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgetShower(
      size: 28.0,
      child: InkWell(
        borderRadius: borderRadius10,
        onTap: onTap,
        child: const Icon(Icons.manage_search_sharp),
      ),
    );
  }
}
