import 'package:flutter/material.dart' show runApp;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart' show App;
import 'src/constants/get.platform.dart';
import 'src/db/isar.dart' show initAppDatum, openDB;
import 'src/pocketbase/auth.store/helpers.dart';
import 'src/utils/themes/themes.dart';

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
