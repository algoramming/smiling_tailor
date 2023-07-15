import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path/path.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/get.platform.dart';
import '../../../../db/paths.dart';
import 'web.empty.download.dart' if (dart.library.html) 'web.download.dart';

class FileHandle {
  // save pdf file function
  static Future<dynamic> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    if (pt.isWeb) {
      return await saveDocumentWeb(name: name, pdf: pdf);
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
  static Future<Uint8List> saveDocumentWeb({
    required String name,
    required pw.Document pdf,
  }) async {
    Uint8List pdfInBytes = await pdf.save();
    webDownload(pdfInBytes, '$name.pdf');
    return pdfInBytes;
  }

  // open pdf file function
  static Future openDocument(dynamic file) async {
    final url = file.path;
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  // open pdf files function
  static Future openDocuments(List<dynamic> files) async {
    for (final file in files) {
      await openDocument(file);
    }
  }

  // delete pdf file function
  static Future<void> deleteDocument(File file) async {
    try {
      await file.delete();
    } catch (e) {
      if (e is FileSystemException) {
        final errorCode = e.osError?.errorCode;
        if (errorCode == 32) {
          EasyLoading.showError(
              'Cannot delete the file because it is being used by another process.');
          return;
        }
      }
      EasyLoading.showError('$e');
    }
  }

  // share pdf file function
  static Future<void> shareDocuments(List<dynamic> files,
      [String subject = 'Smiling Tailor',
      String text = 'Smiling Tailor\'s orders invoices']) async {
    await Share.shareXFiles(
      files
          .map(
            (e) => pt.isNotWeb
                ? XFile(e.path)
                : XFile.fromData(
                    e as Uint8List,
                    name: '${DateTime.now().millisecondsSinceEpoch}.pdf',
                  ),
          )
          .toList(),
      subject: subject,
      text: text,
    );
  }

  // print pdf file function
  static Future<void> printDocuments(List<dynamic> files) async {
    for (final file in files) {
      final pdfData = pt.isWeb ? file : await file.readAsBytes();
      await Printing.layoutPdf(
        onLayout: (_) => pdfData,
        format: PdfPageFormat.a5,
      );
    }
  }
}
