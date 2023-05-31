import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../constants/constants.dart';
import '../../../../../utils/extensions/extensions.dart';
import '../../../../settings/provider/date.format.provider.dart';
import '../../../../settings/provider/time.format.provider.dart';

DateFormat get getClockFormat =>
    DateFormat('${dateFormates.first}  ${timeFormates[1]}');

class ClockWidget extends StatelessWidget {
  const ClockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 8.0),
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      decoration: BoxDecoration(
        borderRadius: borderRadius15,
        color: context.theme.dividerColor.withOpacity(0.15),
      ),
      child: Center(
        child: StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 1)),
            builder: (context, snapshot) {
              return Text(
                getClockFormat.format(DateTime.now()),
                style: context.text.titleMedium!
                    .copyWith(color: context.theme.primaryColor),
              );
            }),
      ),
    );
  }
}
