import 'package:flutter/material.dart';

import '../../../../../constants/constants.dart';
import '../../../../../utils/extensions/extensions.dart';

class InfoTitle extends StatelessWidget {
  const InfoTitle(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 8.0),
      child: Row(
        mainAxisAlignment: mainCenter,
        children: [
          Text(
            '• $label',
            style: context.text.labelLarge!
                .copyWith(color: context.theme.primaryColor),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10.0, top: 2.0),
              height: 1.0,
              color: context.theme.primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
