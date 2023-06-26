import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/get.platform.dart';
import '../../db/db.dart';
import '../../db/paths.dart';
import '../../utils/logger/logger_helper.dart';
import 'custom.auth.store.dart';
import 'web.empty.client.factory.dart'
    if (dart.library.html) 'web.client.factory.dart';

late PocketBase pb;
late bool isServerRunning;

String get httpProtocol => appSettings.useSecureProtocol ? 'https' : 'http';
String get baseUrl => '$httpProtocol://${appSettings.baseUrl}/';

// const globalBaseUrl = 'smilingtailor.pockethost.io';
const globalBaseUrl = 'smilingtailor.fly.dev';
const devBaseUrl = '103.113.227.244:4200';
final localBaseUrl = pt.isNotMobile ? '127.0.0.1:8090' : '10.0.2.2:8090';

Future<void> initPocketbase() async {
  final sprefs = await SharedPreferences.getInstance();
  appDir.sprefs = sprefs;
  pb = PocketBase(
    baseUrl,
    authStore: CustomAuthStore(sprefs),
    httpClientFactory: pt.isWeb ? clientFactoryWeb : null,
  );
  log.i('Pocketbase initialized. AuthStore isValid: ${pb.authStore.isValid}');
  log.i('AuthStore Model: ${pb.authStore.model}');
  await pktbsHealthCheck();
  // await pktbsServerStatus();
}

Future<void> pktbsHealthCheck() async {
  try {
    final health = await pb.health.check();
    if (health.code == 200) {
      isServerRunning = true;
    } else {
      log.e('Server is not running. $health');
      isServerRunning = false;
    }
  } catch (e) {
    log.e('Server is not running. $e');
    isServerRunning = false;
  }
}

///
/// COllections name
///
const users = 'users';
const orders = 'orders';
const vendors = 'vendors';
const employees = 'employees';
const inventories = 'inventories';
const transactions = 'transactions';
