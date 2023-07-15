import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

void webDownload(List<int> bytes, [String? name]) {
  // Encode our file in base64
  final base64 = base64Encode(bytes);
  // Create the link with the file
  final anchor =
      AnchorElement(href: 'data:application/octet-stream;base64,$base64')
        ..target = 'blank';
  // add the name
  if (name != null) anchor.download = name;

  // trigger download
  document.body?.append(anchor);
  anchor.click();
  anchor.remove();
  return;
}

  // final blob = html.Blob([pdfInBytes], 'application/pdf');
  // final url = html.Url.createObjectUrlFromBlob(blob);
  // final anchor = html.document.createElement('a') as html.AnchorElement
  //   ..href = url
  //   ..style.display = 'none'
  //   ..download = '$name.pdf';
  // html.document.body?.children.add(anchor);
  // anchor.click();