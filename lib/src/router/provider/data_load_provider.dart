import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modules/settings/model/settings.model.dart';
import '../../modules/settings/provider/settings.provider.dart';
import '../../utils/logger/logger_helper.dart';

final initialDataLoadProvider = FutureProvider(
  (ref) async {
    final appSettings = ref.watch(settingsProvider);
    log.i('appSettings: ${appSettings.toString()}');
    return appSettings.firstRun
        ? await ref
            .read(settingsProvider.notifier)
            .changeInitSetting(AppSettings()
              ..firstRun = false
              ..firstRunDateTime = DateTime.now().toUtc())
        : true;
  },
);
