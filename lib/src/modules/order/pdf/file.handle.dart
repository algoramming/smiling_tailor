import 'dart:io';

import 'package:path/path.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:url_launcher/url_launcher.dart';

import '../../../db/paths.dart';

class FileHandle {
  // save pdf file function
  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();
    final file = File(join(appDir.invoice.path, '$name.pdf'));
    await file.writeAsBytes(bytes);
    return file;
  }

  // open pdf file function
  static Future openDocument(File file) async {
    final url = file.path;
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  // delete pdf file function
  static Future<void> deleteDocument(File file) async => await file.delete();
}
