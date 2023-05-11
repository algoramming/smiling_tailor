import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

import '../../utils/logger/logger_helper.dart';
import 'custom.auth.store.dart';

late PocketBase pb;

String get httpProtocol => appSettings.useSecureProtocol ? 'https' : 'http';
String get wsProtocol => appSettings.useSecureProtocol ? 'wss' : 'ws';
String get baseUrl => '$httpProtocol://${appSettings.baseUrl}/';
String get wsBaseUrl => '$wsProtocol://${appSettings.baseUrl}';

const globalBaseUrl = 'smiling-tailor.pockethost.io';
const localBaseUrl = '103.113.227.244:4200';

Future<void> initPocketbase() async {
  final sprefs = await SharedPreferences.getInstance();
  pb = PocketBase(appSettings.baseUrl, authStore: CustomAuthStore(sprefs));
  log.i('Pocketbase initialized. AuthStore isValid: ${pb.authStore.isValid}');
  // await pktbsHealthCheck();
  // await pktbsServerStatus();
}

// Future<void> pktbsHealthCheck() async {
//   try {
//     final health = await pb.health.check();
//     if (health.code == 200) {
//       isServerRunning = true;
//     } else {
//       log.e('Server is not running. $health');
//       isServerRunning = false;
//     }
//   } catch (e) {
//     log.e('Server is not running. $e');
//     isServerRunning = false;
//   }
// }

///
/// COllections name
///
const users = 'users';
const products = 'products';
