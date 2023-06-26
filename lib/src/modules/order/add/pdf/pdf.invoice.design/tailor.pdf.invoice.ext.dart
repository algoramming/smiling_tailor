part of 'a.pdf.invoice.dart';

extension TailorPdfInvoice on PdfInvoice {
  //
  Future<dynamic> tailorPdf(String name) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        footer: pdfFooter,
        header: (_) => pdfHeader(name),
        pageTheme: pdfPageTheme(name),
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        build: (_) {
          return [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pdfCompanyIntro(),
                pw.Expanded(child: pw.SizedBox.shrink()),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisSize: pw.MainAxisSize.min,
                    children: [
                      pw.BarcodeWidget(
                        color: PdfColors.teal,
                        barcode: pw.Barcode.qrCode(),
                        data: order.id,
                        height: 42,
                        width: 42,
                      ),
                      pw.SizedBox(height: 1.5 * PdfPageFormat.mm),
                      pw.Text(
                        order.tailorEmployee?.name ?? 'No Name',
                        style: pw.TextStyle(
                          fontSize: 12.5,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                      pw.Text(
                        order.tailorEmployee?.address ?? 'No Address',
                        maxLines: 2,
                        overflow: pw.TextOverflow.clip,
                        style: const pw.TextStyle(fontSize: 8.0),
                      ),
                      pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                      pw.Text(
                        order.tailorEmployee?.email ?? 'No Email',
                        style: const pw.TextStyle(fontSize: 8.0),
                      ),
                      pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                      pw.Text(
                        order.tailorEmployee?.phone ?? 'No Phone',
                        style: const pw.TextStyle(fontSize: 8.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.Divider(
              borderStyle: pw.BorderStyle.solid,
              color: PdfColors.grey400,
            ),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                pdfDateTimeFormat.format(order.created.toLocal()),
                style: pw.TextStyle(
                  fontSize: 8.0,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 3 * PdfPageFormat.mm),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'Order Id:',
                    style: pw.TextStyle(
                      fontSize: 7.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 3,
                  child: pw.Text(
                    order.tailorNote.isNotNullOrEmpty
                        ? '${order.id} - ${order.tailorNote}'
                        : order.id,
                    maxLines: 2,
                    overflow: pw.TextOverflow.clip,
                    style: const pw.TextStyle(fontSize: 7.0),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'Home Delivery:',
                    style: pw.TextStyle(
                      fontSize: 7.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 3,
                  child: pw.Text(
                    order.deliveryEmployee == null
                        ? 'No'
                        : 'Yes - (${order.deliveryEmployee!.name})',
                    maxLines: 2,
                    overflow: pw.TextOverflow.clip,
                    style: const pw.TextStyle(fontSize: 7.0),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'Inventory Purchase:',
                    style: pw.TextStyle(
                      fontSize: 7.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 3,
                  child: pw.Text(
                    order.inventory == null
                        ? 'No'
                        : 'Yes - (${order.inventory!.title} - ${order.inventoryQuantity} ${order.inventoryUnit!.symbol})',
                    maxLines: 2,
                    overflow: pw.TextOverflow.clip,
                    style: const pw.TextStyle(fontSize: 7.0),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'Delivery Time:',
                    style: pw.TextStyle(
                      fontSize: 7.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 3,
                  child: pw.Text(
                    pdfDateTimeFormat.format(order.deliveryTime),
                    maxLines: 2,
                    overflow: pw.TextOverflow.clip,
                    style: pw.TextStyle(
                      fontSize: 7.0,
                      color: PdfColors.teal,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            pw.Table(
              border: null,
              columnWidths: {
                0: const pw.FractionColumnWidth(0.2),
                1: const pw.FractionColumnWidth(0.8),
              },
              children: [
                pw.TableRow(
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(4.0),
                    border: pw.Border.all(color: PdfColors.teal),
                  ),
                  children: List.generate(
                    tailorTableHeaders.length,
                    (i) => pw.Container(
                      padding: const pw.EdgeInsets.all(5.0),
                      child: pw.Text(
                        tailorTableHeaders[i],
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 8.0,
                          color: PdfColors.teal,
                        ),
                      ),
                    ),
                  ),
                ),
                ...List.generate(
                  tailorTableItems.length,
                  (oi) => pw.TableRow(
                    children: List.generate(
                      tailorTableItems[oi].length,
                      (ii) => pw.Container(
                        padding: const pw.EdgeInsets.all(5.0),
                        child: pw.Text(
                          tailorTableItems[oi][ii],
                          textAlign: ii == 1
                              ? pw.TextAlign.justify
                              : pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontWeight: ii == 0
                                ? pw.FontWeight.bold
                                : pw.FontWeight.normal,
                            fontSize: 8.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            pw.Divider(color: PdfColors.teal),
          ];
        },
      ),
    );

    return FileHandle.saveDocument(
      name: '${order.id}-$name-${DateTime.now().millisecondsSinceEpoch}',
      pdf: pdf,
    );
  }
}
