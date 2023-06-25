part of 'a.pdf.invoice.dart';

extension CustomerPdfInvoice on PdfInvoice {
  //
  Future<File> customerPdf(String name) async {
    final pdf = pw.Document();

    final totalGiven = paymentOthersTrxs.fold(
        0.0, (p, c) => p + (c.trxType.isCredit ? c.amount : -c.amount));

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a5,
        margin: const pw.EdgeInsets.all(25.0),
        footer: pdfFooter,
        header: (_) => pdfHeader(name),
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        build: (_) {
          return [
            pw.Stack(
              alignment: pw.Alignment.center,
              children: [
                pw.Container(
                  margin: const pw.EdgeInsets.only(top: 100.0),
                  child: pw.Opacity(
                    opacity: 0.2,
                    child: pw.Image(
                      pw.MemoryImage(icon),
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
                pw.Column(
                  children: [
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
                      color: PdfColors.grey300,
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
                    pw.SizedBox(height: 5 * PdfPageFormat.mm),
                    pw.Row(
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
                                ? '${order.id} - ${order.description?.first50Words}'
                                : order.id,
                            style: const pw.TextStyle(fontSize: 7.0),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                    pw.Row(
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
                            style: const pw.TextStyle(fontSize: 7.0),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                    pw.Row(
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
                            maxLines: 3,
                            overflow: pw.TextOverflow.clip,
                            style: const pw.TextStyle(fontSize: 7.0),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                    pw.Row(
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
                            maxLines: 3,
                            overflow: pw.TextOverflow.clip,
                            style: const pw.TextStyle(fontSize: 7.0),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                    pw.Row(
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
                            style: pw.TextStyle(
                              fontSize: 7.0,
                              color: PdfColors.teal,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                    pw.SizedBox(height: 5 * PdfPageFormat.mm),

                    ///
                    /// PDF Table Create
                    ///
                    pw.TableHelper.fromTextArray(
                      headers: tableHeaders,
                      border: null,
                      data: [
                        [
                          order.tailorNote.isNotNullOrEmpty
                              ? 'Tailor Charge - ${order.tailorNote}'
                              : 'Tailor Charge',
                          order.quantity.toString(),
                          '${tailorTrx?.amount ?? 0.0 / order.quantity}',
                          '${tailorTrx?.amount ?? 0.0}',
                        ],
                        if (order.inventory != null)
                          [
                            order.inventoryNote.isNotNullOrEmpty
                                ? 'Inventory Charge - ${order.inventoryNote}'
                                : 'Inventory Charge',
                            order.inventoryQuantity ?? 0.toString(),
                            '${(inventoryPurchaseTrx?.amount ?? 0.0) / (order.inventoryQuantity ?? 0.0)}',
                            '${inventoryPurchaseTrx?.amount ?? 0.0}',
                          ],
                        if (order.deliveryEmployee != null)
                          [
                            order.deliveryNote.isNotNullOrEmpty
                                ? 'Delivery Charge - ${order.deliveryNote}'
                                : 'Delivery Charge',
                            '',
                            '${deliveryTrx?.amount ?? 0.0}',
                            '${deliveryTrx?.amount ?? 0.0}',
                          ],
                      ],
                      headerStyle: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 8.0),
                      cellStyle: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 8.0),
                      headerDecoration: pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.circular(4.0),
                        border: pw.Border.all(color: PdfColors.teal),
                      ),
                      cellHeight: 22.0,
                      cellAlignments: {
                        0: pw.Alignment.centerLeft,
                        1: pw.Alignment.centerRight,
                        2: pw.Alignment.centerRight,
                        3: pw.Alignment.centerRight,
                      },
                    ),
                    pw.Divider(),
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
                                      '0.0',
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 9.5,
                                      ),
                                    ),
                                  ],
                                ),
                                pw.Divider(),
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
                                      (advanceTrx?.amount ?? 0.0)
                                          .toStringAsFixed(2),
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
                                        'Others Given',
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
                                pw.Divider(),
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
                                pw.Container(
                                    height: 1, color: PdfColors.grey400),
                                pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                                pw.Container(
                                    height: 1, color: PdfColors.grey400),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
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
