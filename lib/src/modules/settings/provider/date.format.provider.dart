import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants.dart';
import '../../../db/hive.dart';
import '../../../utils/extensions/extensions.dart';
import '../model/settings.model.dart';
import 'settings.provider.dart';

const dateFormates = [
  'dd MMM, yy',
  'dd MMM, yyyy',
  'dd/MM/yy',
  'dd/MM/yyyy',
  'dd-MM-yy',
  'dd-MM-yyyy',
  'dd, MM yy',
  'dd, MM yyyy',
  'dd.MM.yy',
  'dd.MM.yyyy',
  'dd MM yy',
  'dd MM yyyy',
];

typedef DateFormatNotifier = NotifierProvider<DateFormatProvider, String>;

final dateFormatProvider = DateFormatNotifier(DateFormatProvider.new);

class DateFormatProvider extends Notifier<String> {
  @override
  String build() => ref.watch(settingsProvider.select((v) => v.dateFormat));

  Future<void> changeDateFormat(String dateFormat) async {
    // await compute(_changeDateFormat, _Data(ref.read(settingsProvider), dateFormat));
    await Boxes.appSettings.put(
        appName.toCamelWord,
        (Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings())
            .copyWith(dateFormat: dateFormat));
  }
}

// class _Data {
//   _Data(this.setting, this.dateFormat);

//   final String dateFormat;
//   final AppSettings setting;
// }

// Future<void> _changeDateFormat(_Data data) async {
//   await initHiveDB();
//   data.setting.dateFormat = data.dateFormat;
//   await Boxes.appSettings.put(appName, data.setting);
// }
