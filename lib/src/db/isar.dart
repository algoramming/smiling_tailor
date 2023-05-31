import 'dart:convert';

import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/services.dart';
import 'package:isar/isar.dart' show Isar, QueryExecute;

import '../modules/settings/model/currency/currency.model.dart';
import '../modules/settings/model/measurement/measurement.dart';
import '../modules/settings/model/settings.model.dart';
import '../utils/logger/logger_helper.dart';
import 'paths.dart' show AppDir, appDir, initDir;

late final Isar db;
late AppSettings appSettings;
late CurrencyProfile currency;

const _schema = [AppSettingsSchema, CurrencyProfileSchema, MeasurementSchema];

Future<void> openDB() async {
  await initDir();
  db = await Isar.open(
    _schema,
    inspector: !kReleaseMode,
    directory: appDir.db.path,
  );
}

void openDBSync(AppDir dir) => db =
    Isar.openSync(_schema, inspector: !kReleaseMode, directory: dir.db.path);

Future<void> initAppDatum() async {
  if (await db.currencyProfiles.where().count() == 0) await currencyInit();
  if (await db.measurements.where().count() == 0) await measurementInit();
  appSettings = await db.appSettings.get(0) ?? AppSettings();
  currency = (await db.currencyProfiles
      .where()
      .shortFormEqualTo(appSettings.currency)
      .findFirst())!;
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
  await measurements.saveAll();
}

void listenForAppConfig() =>
    db.appSettings.watchObjectLazy(0).listen((_) async {
      appSettings = await db.appSettings.get(0) ?? AppSettings();
      currency = (await db.currencyProfiles
          .where()
          .shortFormEqualTo(appSettings.currency)
          .findFirst())!;
    });
