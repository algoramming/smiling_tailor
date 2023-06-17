import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../config/constants.dart';
import '../config/get.platform.dart';
import '../modules/settings/model/currency/currency.model.dart';
import '../modules/settings/model/measurement/measurement.dart';
import '../modules/settings/model/settings.model.dart';
import '../utils/extensions/extensions.dart';
import '../utils/logger/logger_helper.dart';
import 'db.functions.dart';
import 'hive.dart';
import 'paths.dart' show appDir, initDir;

late AppSettings appSettings;
late CurrencyProfile appCurrency;
late List<Measurement> appMeasurements;

Future<void> openDB() async {
  await initDir();
  await initHiveDB();
}

Future<void> initHiveDB() async {
  await Hive.initFlutter(pt.isWeb ? null : appDir.db.path);
  HiveFuntions.registerHiveAdepters();
  await HiveFuntions.openAllBoxes();
}

Future<void> initAppDatum() async {
  if (Boxes.appSettings.isEmpty) await appSettingsInit();
  if (Boxes.currencyProfile.isEmpty) await currencyInit();
  if (Boxes.measurement.isEmpty) await measurementInit();
  appSettings = Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings();
  appCurrency = Boxes.currencyProfile.values
      .toList()
      .firstWhere((e) => e.shortForm == appSettings.currency);
  appMeasurements = Boxes.measurement.values.toList();
  log.i(
      'App Initiated with appSettings: ${appSettings.firstRunDateTime}, currency: ${appCurrency.shortForm} and measurements: ${appMeasurements.length} units');
  listenForAppConfig();
}

Future<void> appSettingsInit() async {
  final appSettings = AppSettings();
  log.i(
      'First time App Settings Initiated with ${appSettings.firstRunDateTime}');
  await appSettings.saveData();
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
  await currencies.saveAllData();
}

Future<void> measurementInit() async {
  List<Measurement> measurements = [];
  final measurementsJson =
      await rootBundle.loadString('assets/json/measurement_data.json');
  final jsonList = jsonDecode(measurementsJson) as List;
  for (final json in jsonList) {
    final curr = Measurement.fromJson(json);
    measurements.add(curr);
  }
  log.i('First time Measurement Initiated with ${measurements.length} units');
  await measurements.saveAllData();
}

void listenForAppConfig() {
  Boxes.appSettings.watch(key: appName.toCamelWord).listen((_) {
    appSettings = Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings();
    appCurrency = Boxes.currencyProfile.values
        .toList()
        .firstWhere((e) => e.shortForm == appSettings.currency);
  });
}
