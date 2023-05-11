import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../db/isar.dart';
import '../../../db/paths.dart';
import '../model/locale/locale.model.dart';
import '../model/settings.model.dart';
import 'settings.provider.dart';

typedef LocaleNotifier = NotifierProvider<LocaleProvider, LocaleProfile>;

final localeProvider = LocaleNotifier(LocaleProvider.new);

class LocaleProvider extends Notifier<LocaleProfile> {
  @override
  LocaleProfile build() => ref.watch(settingsProvider.select((v) => v.locale));

  Future<void> changeLocale(LocaleProfile locale) async =>
      await compute(_changeLocale, _Data(ref.read(settingsProvider), locale));
}

void _changeLocale(_Data data) {
  openDBSync(data.dir);
  data.setting.locale = data.locale;
  db.writeTxnSync(() => db.appSettings.putSync(data.setting));
}

class _Data {
  _Data(this.setting, this.locale);

  final AppDir dir = appDir;
  final LocaleProfile locale;
  final AppSettings setting;
}
