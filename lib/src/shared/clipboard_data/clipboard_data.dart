import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> copyToClipboard(BuildContext context, String text) async =>
    await Clipboard.setData(ClipboardData(text: text));
