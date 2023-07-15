import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants.dart';
import '../../../db/hive.dart';
import '../../../utils/extensions/extensions.dart';
import '../model/currency/currency.model.dart';
import '../model/settings.model.dart';
import 'settings.provider.dart';

typedef CurrencyNotifier = AutoDisposeNotifierProvider<CurrencyProvider, String>;

final currencyProvider = CurrencyNotifier(CurrencyProvider.new);

class CurrencyProvider extends AutoDisposeNotifier<String> {
  final searchCntrlr = TextEditingController();
  late List<CurrencyProfile> _currencies;

  @override
  String build() {
    _listener();
    _currencies = Boxes.currencyProfile.values.toList();
    return ref.watch(settingsProvider.select((v) => v.currency));
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  Future<void> changeCurrency(String currency) async {
    // await compute(_changeCurrency, _Data(ref.read(settingsProvider), currency));
    await Boxes.appSettings.put(
        appName.toCamelWord,
        (Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings())
            .copyWith(currency: currency));
  }

  List<CurrencyProfile> get currencies {
    _currencies.sort((a, b) => a.name.compareTo(b.name));
    final cs = _currencies;
    return cs
        .where((e) =>
            e.name.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.shortForm
                .toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ||
            e.symbol.toLowerCase().contains(searchCntrlr.text.toLowerCase()))
        .toList();
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
