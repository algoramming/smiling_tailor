import 'dart:io';

import 'package:flutter/material.dart';

import '../../../db/isar.dart';
import '../../../db/paths.dart';

Future<void> deleteDB() async {
  debugPrint('Deleting Database : ${appDir.db}');
  final spref = appDir.sprefs;
  await db
      .close(deleteFromDisk: true)
      .then((v) => debugPrint(v ? 'Database Closed!' : 'Database Not Closed!'));
  await appDir.root.delete(recursive: true);
  await spref.clear();
  exit(0);
}
