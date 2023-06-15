import 'dart:io';

import '../../../db/paths.dart';
import '../../../utils/logger/logger_helper.dart';

Future<List<File>> loadFilesFromDirectory() async {
  List<File> files = [];

  try {
    Stream<FileSystemEntity> entityStream =
        appDir.invoice.list(recursive: true);

    await for (final entity in entityStream) {
      if (entity is File) files.add(entity);
    }
  } catch (e) {
    log.e('Error loading files: $e');
  }

  return files;
}
