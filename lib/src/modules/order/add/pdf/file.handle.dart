import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/get.platform.dart';
import '../../../../db/paths.dart';
import 'web.empty.download.dart' if (dart.library.html) 'web.download.dart';

class FileHandle {
  // save pdf file function
  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    if (pt.isWeb) {
      await saveDocumentWeb(name: name, pdf: pdf);
      return File('');
    } else {
      return await saveDocumentNonWeb(name: name, pdf: pdf);
    }
  }

  // save pdf file function for non web
  static Future<File> saveDocumentNonWeb({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();
    final file = File(join(appDir.invoice.path, '$name.pdf'));
    await file.writeAsBytes(bytes);
    return file;
  }

  // save pdf file function for web
  static Future<void> saveDocumentWeb({
    required String name,
    required pw.Document pdf,
  }) async {
    Uint8List pdfInBytes = await pdf.save();
    webDownload(pdfInBytes, '$name.pdf');
  }

  // open pdf file function
  static Future openDocument(File file) async {
    final url = file.path;
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  // open pdf files function
  static Future openDocuments(List<File> files) async {
    for (final file in files) {
      await openDocument(file);
    }
  }

  // delete pdf file function
  static Future<void> deleteDocument(File file) async => await file.delete();

  // share pdf file function
  static Future<void> shareDocuments(List<File> files,
      [String subject = 'Smiling Tailor',
      String text = 'Smiling Tailor\'s orders invoices']) async {
    await Share.shareXFiles(
      files.map((e) => XFile(e.path)).toList(),
      subject: subject,
      text: text,
    );
  }
}
