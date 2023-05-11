import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../db/isar.dart';
import '../../../db/paths.dart';
import '../model/settings.model.dart';
import 'settings.provider.dart';

const currencyFormates = [
  {
    'name': 'in Cores',
    'format': '#,##,##0.00#',
  },
  {
    'name': 'in Billions',
    'format': '#,##0.00',
  },
];

typedef CurrencyFormatNotifier
    = NotifierProvider<CurrencyFormatProvider, String>;

final currencyFormatProvider =
    CurrencyFormatNotifier(CurrencyFormatProvider.new);

class CurrencyFormatProvider extends Notifier<String> {
  @override
  String build() => ref.watch(settingsProvider.select((v) => v.currencyFormat));

  Future<void> changeCurrencyFormat(String currencyFormat) async =>
      await compute(_changeCurrencyFormat,
          _Data(ref.read(settingsProvider), currencyFormat));
}

void _changeCurrencyFormat(_Data data) {
  openDBSync(data.dir);
  data.setting.currencyFormat = data.currencyFormat;
  db.writeTxnSync(() => db.appSettings.putSync(data.setting));
}

class _Data {
  _Data(this.setting, this.currencyFormat);

  final AppDir dir = appDir;
  final String currencyFormat;
  final AppSettings setting;
}
