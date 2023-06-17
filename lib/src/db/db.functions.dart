import 'package:hive/hive.dart';

import '../modules/settings/model/currency/currency.model.dart';
import '../modules/settings/model/locale/locale.model.dart';
import '../modules/settings/model/measurement/measurement.dart';
import '../modules/settings/model/settings.model.dart';
import '../modules/settings/model/theme/theme.model.dart';
import 'hive.dart';

class HiveFuntions {
  static void registerHiveAdepters() {
    Hive.registerAdapter(CurrencyProfileAdapter());
    Hive.registerAdapter(LocaleProfileAdapter());
    Hive.registerAdapter(ThemeProfileAdapter());
    Hive.registerAdapter(MeasurementAdapter());
    Hive.registerAdapter(AppSettingsAdapter());
  }

  static Future<void> openAllBoxes() async {
    await Hive.openBox<CurrencyProfile>(BoxNames.currencyProfile);
    await Hive.openBox<LocaleProfile>(BoxNames.localeProfile);
    await Hive.openBox<ThemeProfile>(BoxNames.themeProfile);
    await Hive.openBox<Measurement>(BoxNames.measurement);
    await Hive.openBox<AppSettings>(BoxNames.appSettings);
  }

  static Future<void> closeAllBoxes() async {
    await Boxes.currencyProfile.close();
    await Boxes.localeProfile.close();
    await Boxes.themeProfile.close();
    await Boxes.measurement.close();
    await Boxes.appSettings.close();
  }

  static Future<void> clearAllBoxes() async {
    await Boxes.currencyProfile.clear();
    await Boxes.localeProfile.clear();
    await Boxes.themeProfile.clear();
    await Boxes.measurement.clear();
    await Boxes.appSettings.clear();
  }

  static Future<void> deleteAllBoxes() async {
    await Hive.deleteBoxFromDisk(BoxNames.currencyProfile);
    await Hive.deleteBoxFromDisk(BoxNames.localeProfile);
    await Hive.deleteBoxFromDisk(BoxNames.themeProfile);
    await Hive.deleteBoxFromDisk(BoxNames.measurement);
    await Hive.deleteBoxFromDisk(BoxNames.appSettings);
  }
}
