import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../db/isar.dart';
import '../../../db/paths.dart';
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

  Future<void> changeDateFormat(String dateFormat) async =>
      await compute(_changeDateFormat, _Data(ref.read(settingsProvider), dateFormat));
}

void _changeDateFormat(_Data data) {
  openDBSync(data.dir);
  data.setting.dateFormat = data.dateFormat;
  db.writeTxnSync(() => db.appSettings.putSync(data.setting));
}

class _Data {
  _Data(this.setting, this.dateFormat);

  final AppDir dir = appDir;
  final String dateFormat;
  final AppSettings setting;
}
