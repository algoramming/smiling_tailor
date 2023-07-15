// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:smiling_tailor/src/config/constants.dart';
// import 'package:smiling_tailor/src/db/hive.dart';
// import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

// import '../../modules/settings/model/settings.model.dart';
// import '../../modules/settings/provider/settings.provider.dart';
// import '../../utils/logger/logger_helper.dart';

// final initialDataLoadProvider = FutureProvider(
//   (ref) async {
//     final appSettings = ref.watch(settingsProvider);
//     log.i('appSettings: ${appSettings.toString()}');
//     return ((Boxes.appSettings.get(appName.toCamelWord)) ?? appSettings)
//             .firstRun
//         ? await ref
//             .read(settingsProvider.notifier)
//             .changeInitSetting(AppSettings()
//               ..firstRun = false
//               ..firstRunDateTime = DateTime.now().toUtc())
//         : true;
//   },
// );
