part of 'a.pdf.invoice.dart';

extension CustomerPdfInvoice on PdfInvoice {
  //
  Future<dynamic> customerPdf(String name) async {
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
                        order.customerName,
                        style: pw.TextStyle(
                          fontSize: 12.5,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                      pw.Text(
                        order.customerAddress ?? '',
                        maxLines: 2,
                        overflow: pw.TextOverflow.clip,
                        style: const pw.TextStyle(fontSize: 8.0),
                      ),
                      pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                      pw.Text(
                        order.customerEmail ?? '',
                        style: const pw.TextStyle(fontSize: 8.0),
                      ),
                      pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                      pw.Text(
                        order.customerPhone,
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
                    order.description.isNotNullOrEmpty
                        ? '${order.id} - ${order.description}'
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
                        : 'Yes - (${order.inventory!.title} - ${inventoryAllocationTrx?.amount ?? 0.0} ${inventoryAllocationTrx?.unit?.symbol})',
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
                    'Payment Method:',
                    style: pw.TextStyle(
                      fontSize: 7.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 3,
                  child: pw.Text(
                    order.paymentNote.isNotNullOrEmpty
                        ? '${order.paymentMethod.label} - ${order.paymentNote}'
                        : order.paymentMethod.label,
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
                0: const pw.FractionColumnWidth(0.6),
                1: const pw.FractionColumnWidth(0.13),
                2: const pw.FractionColumnWidth(0.13),
                3: const pw.FractionColumnWidth(0.13),
              },
              children: [
                pw.TableRow(
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(4.0),
                    border: pw.Border.all(color: PdfColors.teal),
                  ),
                  children: List.generate(
                    customerTableHeaders.length,
                    (i) => pw.Container(
                      padding: const pw.EdgeInsets.all(5.0),
                      child: pw.Text(
                        customerTableHeaders[i],
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
                  customerTableItems.length,
                  (oi) => pw.TableRow(
                    children: List.generate(
                      customerTableItems[oi].length,
                      (ii) => pw.Container(
                        padding: const pw.EdgeInsets.all(5.0),
                        child: pw.Text(
                          customerTableItems[oi][ii],
                          textAlign: ii == 0
                              ? pw.TextAlign.justify
                              : ii == 1
                                  ? pw.TextAlign.center
                                  : pw.TextAlign.right,
                          style: pw.TextStyle(
                            fontWeight: ii == 0
                                ? pw.FontWeight.normal
                                : pw.FontWeight.bold,
                            fontSize: 8.0,
                          ),
                          maxLines: 2,
                          overflow: pw.TextOverflow.clip,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            pw.Divider(color: PdfColors.teal),
            pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Row(
                children: [
                  pw.Spacer(flex: 6),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisSize: pw.MainAxisSize.min,
                      children: [
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Net total',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 9.5,
                                ),
                              ),
                            ),
                            pw.Text(
                              order.amount.toStringAsFixed(2),
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 9.5,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Vat 0.0 %',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 9.5,
                                ),
                              ),
                            ),
                            pw.Text(
                              '0.00',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 9.5,
                              ),
                            ),
                          ],
                        ),
                        pw.Divider(color: PdfColors.teal),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Gross total',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 9.5,
                                ),
                              ),
                            ),
                            pw.Text(
                              order.amount.toStringAsFixed(2),
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 9.5,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Advance Payment',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 9.5,
                                ),
                              ),
                            ),
                            pw.Text(
                              (advanceTrx?.amount ?? 0.0).toStringAsFixed(2),
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 9.5,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Collection',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 9.5,
                                ),
                              ),
                            ),
                            pw.Text(
                              totalGiven.toStringAsFixed(2),
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 9.5,
                              ),
                            ),
                          ],
                        ),
                        pw.Divider(color: PdfColors.teal),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Due',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 9.5,
                                ),
                              ),
                            ),
                            pw.Text(
                              (order.amount -
                                      (advanceTrx?.amount ?? 0.0) -
                                      totalGiven)
                                  .toStringAsFixed(2),
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 9.5,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Container(height: 1, color: PdfColors.teal400),
                        pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                        pw.Container(height: 1, color: PdfColors.teal400),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
