import 'package:flutter/material.dart' show runApp;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ProviderContainer, UncontrolledProviderScope;
import 'package:smiling_tailor/src/constants/get.platform.dart';
import 'package:smiling_tailor/src/modules/settings/model/settings.model.dart';
import 'package:smiling_tailor/src/modules/settings/provider/settings.provider.dart';
import 'package:smiling_tailor/src/utils/logger/logger_helper.dart';

import 'src/app.dart' show App;
import 'src/db/isar.dart' show openDB;
import 'src/utils/themes/themes.dart';

AppSettings? appSettings;

void main() async {
  runApp(UncontrolledProviderScope(
    container: await _init(),
    child: const App(),
  ));
  SystemChrome.setSystemUIOverlayStyle(uiConfig);
}

Future<ProviderContainer> _init() async {
  pt = PlatformInfo.getCurrentPlatformType();
  await openDB();
  return _appSettingsTrack();
}

Future<ProviderContainer> _appSettingsTrack() async {
  final container = ProviderContainer();
  container.listen(
    settingsStreamProvider,
    (_, c) {
      log.wtf('Global appSettings Change: ${c.value.toString()}');
      appSettings = c.value;
    },
  );

  return container;
}
