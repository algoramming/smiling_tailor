import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:isar/isar.dart' show Isar;

import '../modules/settings/model/currency/currency.model.dart';
import '../modules/settings/model/settings.model.dart';
import 'paths.dart' show AppDir, appDir, initDir;


late final Isar db;

const _schema = [AppSettingsSchema, CurrencyProfileSchema];

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
