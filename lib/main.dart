import 'dart:convert';

import 'package:flutter/material.dart' show runApp;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:smiling_tailor/src/modules/settings/model/currency/currency.model.dart';
import 'package:smiling_tailor/src/utils/logger/logger_helper.dart';

import 'src/app.dart' show App;
import 'src/constants/get.platform.dart';
import 'src/db/isar.dart' show db, openDB;
import 'src/modules/settings/model/settings.model.dart';
import 'src/pocketbase/auth.store/helpers.dart';
import 'src/utils/themes/themes.dart';

late AppSettings appSettings;
CurrencyProfile? currency;

void main() async {
  await _init();
  runApp(const ProviderScope(child: App()));
  SystemChrome.setSystemUIOverlayStyle(uiConfig);
}

Future<void> _init() async {
  pt = PlatformInfo.getCurrentPlatformType();
  await openDB();
  await initAppDatum();
  await initPocketbase();
}

Future<void> initAppDatum() async {
  if (await db.currencyProfiles.where().count() == 0) await currencyInit();
  appSettings = await db.appSettings.get(0) ?? AppSettings();
  currency = await db.currencyProfiles
      .where()
      .shortFormEqualTo(appSettings.currency)
      .findFirst();
  listenForAppConfig();
}

Future<void> currencyInit() async {
  List<CurrencyProfile> currencies = [];
  final currenciesJson =
      await rootBundle.loadString('assets/json/currency_data.json');
  final jsonList = jsonDecode(currenciesJson) as List;
  for (final json in jsonList) {
    final curr = CurrencyProfile.fromJson(json);
    currencies.add(curr);
  }
  log.i('First time Currency Initiated with ${currencies.length} currencies');
  await currencies.saveAll();
}

void listenForAppConfig() =>
    db.appSettings.watchObjectLazy(0).listen((_) async {
      appSettings = await db.appSettings.get(0) ?? AppSettings();
      currency = await db.currencyProfiles
          .where()
          .shortFormEqualTo(appSettings.currency)
          .findFirst();
    });
