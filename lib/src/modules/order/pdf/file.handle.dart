import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class FileHandleApi {
  // save pdf file function
  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File(join(dir.path, name));
    await file.writeAsBytes(bytes);
    return file;
  }

  // open pdf file function
  // static Future openFile(File file) async {
  //   final url = file.path;
  // }
}
