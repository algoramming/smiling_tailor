import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart' show runApp;
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart' show App;
import 'src/config/get.platform.dart';
import 'src/db/db.dart' show initAppDatum, openDB;
import 'src/pocketbase/auth.store/helpers.dart';
import 'src/utils/themes/themes.dart';

void main() async {
  await _init();
  runApp(const ProviderScope(child: App()));
  SystemChrome.setSystemUIOverlayStyle(uiConfig);
}

Future<void> _init() async {
  Beamer.setPathUrlStrategy();
  pt = PlatformInfo.getCurrentPlatformType();
  await openDB();
  configLoading();
  await initAppDatum();
  await initPocketbase();
}

void configLoading() {
  EasyLoading.instance
    ..dismissOnTap = false
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle;
}
