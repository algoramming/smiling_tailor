import 'package:flutter/material.dart';

import 'awesome_snackbar.dart';
import 'timer_snackbar.dart';

final snackbarKey = GlobalKey<ScaffoldMessengerState>();

void showTimerSnackbar(String message, [int second = 3]) =>
    timerSnackbar(contentText: message, second: second);

void showAwesomeSnackbar(String title, String message, MessageType messageType,
    [int? second]) {
  final snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    duration: Duration(
        seconds: second ?? (messageType == MessageType.failure ? 5 : 3)),
    content: AwesomeSnackbarContent(
      title: title,
      message: message,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      messageType: messageType,
    ),
  );

  ScaffoldMessenger.of(snackbarKey.currentContext!)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
