import 'package:flutter/material.dart';

import '../../../../config/constants.dart';
import '../../../../shared/text.size/text.size.dart';
import '../../../../utils/extensions/extensions.dart';

class GraphSummary extends StatelessWidget {
  const GraphSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Builder(builder: (_) {
            final width = calculateTextSize('Transaction Summary',
                    style: context.text.titleLarge)
                .width;
            return Row(
              mainAxisAlignment: mainCenter,
              children: [
                Column(
                  children: [
                    Text(
                      'Transaction Summary',
                      style: context.text.titleLarge,
                    ),
                    const SizedBox(height: 2.0),
                    Container(
                      height: 1.8,
                      width: width,
                      color: context.theme.primaryColor.withOpacity(0.5),
                    ),
                    const SizedBox(height: 2.0),
                    Container(
                      height: 1.8,
                      width: width,
                      color: context.theme.primaryColor.withOpacity(0.7),
                    ),
                  ],
                ),
                const Spacer(),
                Switch.adaptive(
                  value: false,
                  onChanged: (_) {},
                ),
              ],
            );
          }),
          const SizedBox(height: 10.0),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 80.0),
            child: Text(
              'No Transaction Yet. In developement phase...',
              style: context.text.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
