import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../db/isar.dart';
import '../../../db/paths.dart';
import '../model/currency/currency.model.dart';
import '../model/settings.model.dart';
import 'settings.provider.dart';

typedef CurrencyNotifier = AsyncNotifierProvider<CurrencyProvider, String>;

final currencyProvider = CurrencyNotifier(CurrencyProvider.new);

class CurrencyProvider extends AsyncNotifier<String> {

  late List<CurrencyProfile> currencies;
  
  @override
  FutureOr<String> build() async {
    currencies = [];
    final currenciesJson = await rootBundle.loadString('assets/json/currency_data.json');
    final jsonList = jsonDecode(currenciesJson) as List;
    for (final json in jsonList) {
      final curr = CurrencyProfile.fromJson(json);
      currencies.add(curr);
    }
    return ref.watch(settingsProvider.select((v) => v.currency));
  }

  Future<void> changeCurrency(String currency) async =>
      await compute(_changeCurrency, _Data(ref.read(settingsProvider), currency));
}

void _changeCurrency(_Data data) {
  openDBSync(data.dir);
  data.setting.currency = data.currency;
  db.writeTxnSync(() => db.appSettings.putSync(data.setting));
}

class _Data {
  _Data(this.setting, this.currency);

  final AppDir dir = appDir;
  final String currency;
  final AppSettings setting;
}
