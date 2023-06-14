// // ignore: implementation_imports
// import 'package:pocketbase/src/sse/sse_client.dart';

// import '../../utils/logger/logger_helper.dart';
// import '../auth.store/helpers.dart';

// late bool isServerRunning;

// Future<void> pktbsServerStatus() async {
//   final sse = SseClient(
//     '$baseUrl/api/realtime',
//     onClose: () => log.i('on final disconnect...'),
//     onError: (e) {
//       //on reconnect attempt
//       // (will happen on server idle reconnect or no internet connectivity)
//       log.e(' Pktbs Server disconnected! $e - ${DateTime.now()}');
//       isServerRunning = false;
//     },
//   );

//   // you can eventually attach to the onMessage stream
//   // (but for this particular use case you may not need it since you don't have any subscriptions)
//   sse.onMessage.listen(
//     (msg) {
//       log.i('Pktbs SSE Message: $msg - ${DateTime.now()}');
//       isServerRunning = true;
//     },
//     cancelOnError: true,
//     onDone: () => log.i('Pktbs on done... ${DateTime.now()}'),
//     onError: (e) => log.e('Pktbs on error... $e - ${DateTime.now()}'),
//   );

//   // close the connection and clean up any resources associated with it
//   // sse.close();
// }
