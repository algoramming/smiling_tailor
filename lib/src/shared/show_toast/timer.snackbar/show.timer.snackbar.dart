import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'timer.snackbar.dart';

void showTimerSnackbar(
  BuildContext context, {
  /// Main body message
  required String contentText,

  /// action button prefix child
  Widget? buttonPrefixWidget,

  /// button label
  String buttonLabel = 'Undo',

  /// This method will execute after time finish. The default time is 4 seconds.
  required void Function() onTap,

  /// default time set 2 seconds.
  int second = 2,

  /// default backgorund color [Colors.grey[850]]
  Color? backgroundColor,

  /// default TextStyle is none.
  TextStyle? contentTextStyle,

  /// Alignment of the content text
  Alignment alignment = Alignment.center,
}) {
  final snackbar = SnackBar(
    content: TimerSnackbarContent(
      contentText: contentText,
      buttonPrefixWidget: buttonPrefixWidget,
      buttonLabel: buttonLabel,
      onTap: onTap,
      second: second,
      contentTextStyle: contentTextStyle,
      alignment: alignment,
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: second),
    margin: const EdgeInsets.all(6.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
  );

  // EasyLoading.dismiss();
  if (EasyLoading.isShow) EasyLoading.dismiss();

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackbar);
}
