import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db/isar.dart';
import '../../utils/logger/logger_helper.dart';
import 'custom.auth.store.dart';

late PocketBase pb;

String get httpProtocol => appSettings.useSecureProtocol ? 'https' : 'http';
String get baseUrl => '$httpProtocol://${appSettings.baseUrl}/';

const globalBaseUrl = 'smiling-tailor.pockethost.io';
const localBaseUrl = '127.0.0.1:8090';
// const localBaseUrl = '103.113.227.244:4200';

Future<void> initPocketbase() async {
  final sprefs = await SharedPreferences.getInstance();
  pb = PocketBase(baseUrl, authStore: CustomAuthStore(sprefs));
  log.i('Pocketbase initialized. AuthStore isValid: ${pb.authStore.isValid}');
  log.i('AuthStore Model: ${pb.authStore.model}');
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
const orders = 'orders';
const vendors = 'vendors';
const employees = 'employees';
const inventories = 'inventories';
const transactions = 'transactions';

Future<void> unsubscribeAllCollections() async {
  await pb.collection(users).unsubscribe('*');
  await pb.collection(orders).unsubscribe('*');
  await pb.collection(vendors).unsubscribe('*');
  await pb.collection(employees).unsubscribe('*');
  await pb.collection(inventories).unsubscribe('*');
  await pb.collection(transactions).unsubscribe('*');
}
