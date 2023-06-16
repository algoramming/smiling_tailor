import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../config/constants.dart';
import '../../../db/hive.dart';
import '../model/currency/currency.model.dart';
import '../model/settings.model.dart';
import 'settings.provider.dart';

typedef CurrencyNotifier = NotifierProvider<CurrencyProvider, String>;

final currencyProvider = CurrencyNotifier(CurrencyProvider.new);

class CurrencyProvider extends Notifier<String> {
  late List<CurrencyProfile> currencies;

  @override
  String build() {
    currencies = Boxes.currencyProfile.values.toList();
    return ref.watch(settingsProvider.select((v) => v.currency));
  }

  Future<void> changeCurrency(String currency) async {
    // await compute(_changeCurrency, _Data(ref.read(settingsProvider), currency));
    await Boxes.appSettings.put(
        appName.toCamelWord,
        (Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings())
            .copyWith(currency: currency));
  }
}

// class _Data {
//   _Data(this.setting, this.currency);

//   final String currency;
//   final AppSettings setting;
// }

// Future<void> _changeCurrency(_Data data) async {
//   await initHiveDB();
//   data.setting.currency = data.currency;
//   await Boxes.appSettings.put(appName, data.setting);
// }
