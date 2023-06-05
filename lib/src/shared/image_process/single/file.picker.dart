import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

import '../../../config/constants.dart';
import '../../../utils/logger/logger_helper.dart';

Future<PlatformFile?> filePickFromDevice() async {
  try {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.image,
      dialogTitle: appName,
    );
    if (file == null) return null;
    return file.files.single;
  } on PlatformException catch (e) {
    log.e('No Image found. Error: $e');
    return null;
  }
}
