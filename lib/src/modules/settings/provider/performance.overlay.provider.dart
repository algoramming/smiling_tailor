import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants.dart';
import '../../../db/hive.dart';
import '../../../utils/extensions/extensions.dart';
import '../model/settings.model.dart';
import 'settings.provider.dart';

typedef PerformanceOverlayNotifier
    = NotifierProvider<PerformanceOverlayProvider, bool>;

final performanceOverlayProvider =
    PerformanceOverlayNotifier(PerformanceOverlayProvider.new);

class PerformanceOverlayProvider extends Notifier<bool> {
  @override
  bool build() =>
      ref.watch(settingsProvider.select((v) => v.performanceOverlayEnable));

  Future<void> changePerformanceOverlay(bool isEnable) async {
    // await compute(_changePerformanceOverlay, _Data(ref.read(settingsProvider), isEnable));
    await Boxes.appSettings.put(
        appName.toCamelWord,
        (Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings())
            .copyWith(performanceOverlayEnable: isEnable));
  }
}

// class _Data {
//   _Data(this.setting, this.isEnable);

//   final bool isEnable;
//   final AppSettings setting;
// }

// Future<void> _changePerformanceOverlay(_Data data) async {
//   await initHiveDB();
//   data.setting.performanceOverlayEnable = data.isEnable;
//   await Boxes.appSettings.put(appName, data.setting);
// }
