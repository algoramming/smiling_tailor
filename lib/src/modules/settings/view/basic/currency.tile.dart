import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/constants.dart';
import '../../../../localization/loalization.dart';
import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/error_widget/error_widget.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../shared/loading_widget/loading_widget.dart';
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
            ref.watch(currencyProvider).value ?? 'BDT',
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
    final currencies = ref.watch(currencyProvider.notifier).currencies;
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
        content: SingleChildScrollView(
          child: ref.watch(currencyProvider).when(
            loading: () => const LoadingWidget(withScaffold: false, heightWidth: 100),
            error: (err, _) => KErrorWidget(withScaffold: false, error: err),
            data:(_) => Column(
              children: [
                ...List.generate(
                  currencies.length,
                  (index) => KListTile(
                    onTap: () async => await ref
                        .read(currencyProvider.notifier)
                        .changeCurrency(currencies[index].shortForm)
                        .then((_) => Navigator.of(context).pop()),
                    leading: Radio<String?>(
                      value: currencies[index].shortForm,
                      groupValue: ref.watch(currencyProvider).value ?? 'BDT',
                      onChanged: (v) async => await ref
                          .read(currencyProvider.notifier)
                          .changeCurrency(v!)
                          .then((_) => Navigator.of(context).pop()),
                    ),
                    trailing: OutlinedButton.icon(
                      onPressed: null,
                      icon: Text(
                        currencies[index].shortForm,
                        style: const TextStyle(fontSize: 13.0),
                      ),
                      label: Text(
                        currencies[index].symbol,
                        style: TextStyle(
                            fontSize: 13.0, color: context.theme.primaryColor),
                      ),
                    ),
                    title: Text(
                      currencies[index].name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
