import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../config/constants.dart';
import '../../../../localization/loalization.dart';
import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../provider/date.format.provider.dart';

class DateFormatTile extends StatelessWidget {
  const DateFormatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: SvgPicture.asset(
          'assets/svgs/date-format.svg',
          colorFilter: context.theme.primaryColor.toColorFilter,
          semanticsLabel: 'Date Format',
        ),
      ),
      title: Text(
        t.dateFormat,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: OutlinedButton.icon(
        onPressed: () async => await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const DateFormatChangerPopup(),
        ),
        label: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 15.0,
          color: context.theme.primaryColor,
        ),
        icon: Consumer(builder: (_, ref, __) {
          return Text(
            DateFormat(ref.watch(dateFormatProvider)).format(DateTime.now()),
            style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 13.0),
          );
        }),
      ),
    );
  }
}

class DateFormatChangerPopup extends ConsumerWidget {
  const DateFormatChangerPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedPopup(
      child: AlertDialog(
        title: Row(
          children: [
            const Text('Select Date Format'),
            const Spacer(),
            const SizedBox(width: 10.0),
            InkWell(
              customBorder: roundedRectangleBorder30,
              child: const Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(
                dateFormates.length,
                (index) => KListTile(
                  onTap: () async => await ref
                      .read(dateFormatProvider.notifier)
                      .changeDateFormat(dateFormates[index])
                      .then((_) => Navigator.of(context).pop()),
                  leading: Radio<String?>(
                    value: dateFormates[index],
                    groupValue: ref.watch(dateFormatProvider),
                    onChanged: (v) async => await ref
                        .read(dateFormatProvider.notifier)
                        .changeDateFormat(v!)
                        .then((_) => Navigator.of(context).pop()),
                  ),
                  title: Text(
                    DateFormat(dateFormates[index]).format(DateTime.now()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
