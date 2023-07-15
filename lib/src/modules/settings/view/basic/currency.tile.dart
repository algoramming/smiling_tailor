import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/constants.dart';
import '../../../../localization/loalization.dart';
import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/clipboard_data/clipboard_data.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../shared/page_not_found/page_not_found.dart';
import '../../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../provider/currency.provider.dart';

class CurrencyTile extends StatelessWidget {
  const CurrencyTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: SvgPicture.asset(
          'assets/svgs/currency.svg',
          colorFilter: context.theme.primaryColor.toColorFilter,
          semanticsLabel: 'Currency',
        ),
      ),
      title: Text(
        t.currency,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: OutlinedButton.icon(
        onPressed: () async {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const CurrencyChangerPopup(),
          );
        },
        label: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 15.0,
          color: context.theme.primaryColor,
        ),
        icon: Consumer(builder: (_, ref, __) {
          return Text(
            ref.watch(currencyProvider) ?? 'BDT',
            style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 13.0),
          );
        }),
      ),
    );
  }
}

class CurrencyChangerPopup extends ConsumerWidget {
  const CurrencyChangerPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(currencyProvider);
    final notifier = ref.watch(currencyProvider.notifier);
    return AnimatedPopup(
      child: AlertDialog(
        title: Row(
          children: [
            const Text('Select Currency'),
            const Spacer(),
            const SizedBox(width: 10.0),
            InkWell(
              customBorder: roundedRectangleBorder30,
              child: const Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        content: SizedBox(
          width: min(400, context.width),
          child: Column(
            children: [
              TextFormField(
                controller: notifier.searchCntrlr,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon:
                      ClearPrefixIcon(() => notifier.searchCntrlr.clear()),
                  suffixIcon: PasteSuffixIcon(() async =>
                      notifier.searchCntrlr.text = await getCliboardData()),
                ),
              ),
              Flexible(
                child: notifier.currencies.isEmpty
                    ? const KDataNotFound()
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                              notifier.currencies.length,
                              (index) => KListTile(
                                onTap: () async => await ref
                                    .read(currencyProvider.notifier)
                                    .changeCurrency(
                                        notifier.currencies[index].shortForm)
                                    .then((_) => Navigator.of(context).pop()),
                                leading: Radio<String?>(
                                  value: notifier.currencies[index].shortForm,
                                  groupValue:
                                      ref.watch(currencyProvider) ?? 'BDT',
                                  onChanged: (v) async => await ref
                                      .read(currencyProvider.notifier)
                                      .changeCurrency(v!)
                                      .then((_) => Navigator.of(context).pop()),
                                ),
                                trailing: OutlinedButton.icon(
                                  onPressed: null,
                                  icon: Text(
                                    notifier.currencies[index].shortForm,
                                    style: const TextStyle(fontSize: 13.0),
                                  ),
                                  label: Text(
                                    notifier.currencies[index].symbol,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: context.theme.primaryColor),
                                  ),
                                ),
                                title: Text(
                                  notifier.currencies[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
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
