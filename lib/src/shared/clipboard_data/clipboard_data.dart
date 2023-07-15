import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../show_toast/awsome.snackbar/show.awesome.snackbar.dart';

Future<void> copyToClipboard(BuildContext context, String text,
    {bool showToast = true}) async {
  await Clipboard.setData(ClipboardData(text: text)).then((_) {
    if (!showToast) return;
    showAwesomeSnackbar(context, 'Success!', 'Copied to clipboard! [$text]',
        MessageType.success, 1);
  });
}

Future<String> getCliboardData() async {
  final data = await Clipboard.getData(Clipboard.kTextPlain);
  return data?.text ?? '';
}
