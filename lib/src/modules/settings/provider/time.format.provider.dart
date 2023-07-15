import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants.dart';
import '../../../db/hive.dart';
import '../../../utils/extensions/extensions.dart';
import '../model/settings.model.dart';
import 'settings.provider.dart';

const timeFormates = [
  'hh:mm a',
  'hh:mm:ss a',
  'hh:mm',
  'hh:mm:ss',
  'HH:mm',
  'HH:mm:ss',
];

typedef TimeFormatNotifier = NotifierProvider<TimeFormatProvider, String>;

final timeFormatProvider = TimeFormatNotifier(TimeFormatProvider.new);

class TimeFormatProvider extends Notifier<String> {
  @override
  String build() => ref.watch(settingsProvider.select((v) => v.timeFormat));

  Future<void> changeTimeFormat(String timeFormat) async {
    // await compute(_changeTimeFormat, _Data(ref.read(settingsProvider), timeFormat));
    await Boxes.appSettings.put(
        appName.toCamelWord,
        (Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings())
            .copyWith(timeFormat: timeFormat));
  }
}

// void _changeTimeFormat(_Data data) {
//   openDBSync(data.dir);
//   data.setting.timeFormat = data.timeFormat;
//   db.writeTxnSync(() => db.appSettings.putSync(data.setting));
// }

// class _Data {
//   _Data(this.setting, this.timeFormat);

//   final AppDir dir = appDir;
//   final String timeFormat;
//   final AppSettings setting;
// }
