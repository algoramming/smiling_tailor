import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants.dart';
import '../../../db/hive.dart';
import '../../../utils/extensions/extensions.dart';
import '../model/locale/locale.model.dart';
import '../model/settings.model.dart';
import 'settings.provider.dart';

typedef LocaleNotifier = NotifierProvider<LocaleProvider, LocaleProfile>;

final localeProvider = LocaleNotifier(LocaleProvider.new);

class LocaleProvider extends Notifier<LocaleProfile> {
  @override
  LocaleProfile build() => ref.watch(settingsProvider.select((v) => v.locale));

  Future<void> changeLocale(LocaleProfile locale) async {
    // await compute(_changeLocale, _Data(ref.read(settingsProvider), locale));
    await Boxes.appSettings.put(
        appName.toCamelWord,
        (Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings())
            .copyWith(locale: locale));
  }
}

// class _Data {
//   _Data(this.setting, this.locale);

//   final LocaleProfile locale;
//   final AppSettings setting;
// }

// Future<void> _changeLocale(_Data data) async {
//   await initHiveDB();
//   data.setting.locale = data.locale;
//   await Boxes.appSettings.put(appName, data.setting);
// }
