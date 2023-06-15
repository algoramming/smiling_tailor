import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'awesome.snackbar.dart';

// final snackbarKey = GlobalKey<ScaffoldMessengerState>();

void showAwesomeSnackbar(
    BuildContext context, String title, String message, MessageType messageType,
    [int? second]) {
  final snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    duration: Duration(
        seconds: second ?? (messageType == MessageType.failure ? 4 : 2)),
    content: AwesomeSnackbarContent(
      title: title,
      message: message,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      messageType: messageType,
    ),
  );

  // EasyLoading.dismiss();
  if (EasyLoading.isShow) EasyLoading.dismiss();

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
