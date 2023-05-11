import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../db/isar.dart';
import '../../../db/paths.dart';
import '../model/settings.model.dart';
import 'settings.provider.dart';

typedef PerformanceOverlayNotifier = NotifierProvider<PerformanceOverlayProvider, bool>;

final performanceOverlayProvider = PerformanceOverlayNotifier(PerformanceOverlayProvider.new);

class PerformanceOverlayProvider extends Notifier<bool> {
  @override
  bool build() => ref.watch(settingsProvider.select((v) => v.performanceOverlayEnable));

  Future<void> changePerformanceOverlay(bool isEnable) async =>
      await compute(
      _changePerformanceOverlay, _Data(ref.read(settingsProvider), isEnable));
}

void _changePerformanceOverlay(_Data data) {
  openDBSync(data.dir);
  data.setting.performanceOverlayEnable = data.isEnable;
  db.writeTxnSync(() => db.appSettings.putSync(data.setting));
}

class _Data {
  _Data(this.setting, this.isEnable);

  final AppDir dir = appDir;
  final bool isEnable;
  final AppSettings setting;
}
