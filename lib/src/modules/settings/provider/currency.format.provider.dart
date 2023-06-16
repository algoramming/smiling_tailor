import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../config/constants.dart';
import '../../../db/hive.dart';
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

  Future<void> changeCurrencyFormat(String currencyFormat) async {
    // await compute(_changeCurrencyFormat, _Data(ref.read(settingsProvider), currencyFormat));
    await Boxes.appSettings.put(
        appName.toCamelWord,
        (Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings())
            .copyWith(currencyFormat: currencyFormat));
  }
}

// class _Data {
//   _Data(this.setting, this.currencyFormat);

//   final String currencyFormat;
//   final AppSettings setting;
// }

// Future<void> _changeCurrencyFormat(_Data data) async {
//   await initHiveDB();
//   data.setting.currencyFormat = data.currencyFormat;
//   await Boxes.appSettings.put(appName, data.setting);
// }