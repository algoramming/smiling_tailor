import 'package:flutter/material.dart' show runApp;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/constants/get.platform.dart';
import 'src/modules/settings/model/settings.model.dart';
import 'src/pocketbase/auth.store/helpers.dart';

import 'src/app.dart' show App;
import 'src/db/isar.dart' show db, openDB;
import 'src/utils/themes/themes.dart';

late AppSettings appSettings;

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
  appSettings = await db.appSettings.get(0) ?? AppSettings();
  listenForAppConfig();
}

void listenForAppConfig() => db.appSettings.watchObjectLazy(0).listen(
    (_) async => appSettings = await db.appSettings.get(0) ?? AppSettings());
