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
import '../../provider/currency.format.provider.dart';

class CurrencyFormatTile extends StatelessWidget {
  const CurrencyFormatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: SvgPicture.asset(
          'assets/svgs/currency-format.svg',
          colorFilter: context.theme.primaryColor.toColorFilter,
          semanticsLabel: 'Currency Format',
        ),
      ),
      title: Text(
        t.currencyFormat,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: OutlinedButton.icon(
        onPressed: () async {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const CurrencyFormatChangerPopup(),
          );
        },
        label: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 15.0,
          color: context.theme.primaryColor,
        ),
        icon: Consumer(
          builder: (_, ref, __) => Text(
            NumberFormat(ref.watch(currencyFormatProvider)).format(10000000),
            style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 13.0),
          ),
        ),
      ),
    );
  }
}

class CurrencyFormatChangerPopup extends StatelessWidget {
  const CurrencyFormatChangerPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        title: Row(
          children: [
            const Text('Select Currency Format'),
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
                currencyFormates.length,
                (index) => Consumer(
                  builder: (_, ref, __) => KListTile(
                    onTap: () async => await ref
                        .read(currencyFormatProvider.notifier)
                        .changeCurrencyFormat(
                            currencyFormates[index]['format']!)
                        .then((_) => Navigator.pop(context)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10.0),
                    leading: Radio<String?>(
                      value: currencyFormates[index]['format'],
                      groupValue: ref.watch(currencyFormatProvider),
                      onChanged: (v) async => await ref
                          .read(currencyFormatProvider.notifier)
                          .changeCurrencyFormat(v!)
                          .then((_) => Navigator.pop(context)),
                    ),
                    title: Text(
                      NumberFormat(currencyFormates[index]['format'])
                          .format(10000000),
                    ),
                    subtitle: Text(currencyFormates[index]['name']!),
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
