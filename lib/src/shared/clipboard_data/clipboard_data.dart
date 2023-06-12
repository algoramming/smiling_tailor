import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../show_toast/awesome_snackbar.dart';
import '../show_toast/show_toast.dart';

Future<void> copyToClipboard(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text)).then((_) =>
      showAwesomeSnackbar(
          context, 'Success!', 'Copied to clipboard!', MessageType.success, 1));
}
