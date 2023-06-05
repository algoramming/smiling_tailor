import 'package:flutter/material.dart';

import '../../config/constants.dart';

class KRadioButton extends StatelessWidget {
  const KRadioButton({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.label,
    required this.groupValue,
    required this.onLabelTap,
    this.style,
  }) : super(key: key);

  final String label;
  final int value;
  final int groupValue;
  final void Function(int?)? onChanged;
  final void Function() onLabelTap;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: mainMin,
      children: [
        Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        const SizedBox(width: 3.0),
        InkWell(
          onTap: onLabelTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              label,
              style: style ?? const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
