import 'package:flutter/material.dart';

import '../../config/constants.dart';

class KRadioButton extends StatelessWidget {
  const KRadioButton({
    super.key,
    required this.value,
    required this.label,
    required this.groupValue,
    required this.onTap,
    this.style,
  });

  final String label;
  final int value;
  final int groupValue;
  final void Function() onTap;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius25,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
        child: Row(
          mainAxisSize: mainMin,
          children: [
            Radio(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              value: value,
              groupValue: groupValue,
              onChanged: (_) => onTap(),
            ),
            const SizedBox(width: 3.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                label,
                style: style ?? const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(width: 3.0),
          ],
        ),
      ),
    );
  }
}
