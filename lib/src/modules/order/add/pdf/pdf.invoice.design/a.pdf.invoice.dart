import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:smiling_tailor/src/db/db.dart';
import 'package:smiling_tailor/src/modules/order/enum/order.enum.dart';
import 'package:smiling_tailor/src/modules/settings/model/settings.model.dart';
import 'package:smiling_tailor/src/modules/transaction/enum/trx.type.dart';
import 'package:smiling_tailor/src/modules/transaction/model/transaction.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../../settings/provider/date.format.provider.dart';
import '../../../../settings/provider/time.format.provider.dart';
import '../../../model/order.dart';
import '../file.handle.dart';

part 'cashier.pdf.invoice.ext.dart';
part 'customer.pdf.invoice.ext.dart';
part 'tailor.pdf.invoice.ext.dart';
part 'zzz.pdf.invoice.ext.dart';

class PdfInvoice {
  final Uint8List icon;
  final PktbsOrder order;
  final PktbsTrx? tailorTrx;
  final PktbsTrx? advanceTrx;
  final PktbsTrx? deliveryTrx;
  final PktbsTrx? inventoryPurchaseTrx;
  final List<PktbsTrx> paymentOthersTrxs;
  final PktbsTrx? inventoryAllocationTrx;

  PdfInvoice({
    required this.icon,
    required this.order,
    required this.tailorTrx,
    required this.advanceTrx,
    required this.deliveryTrx,
    required this.paymentOthersTrxs,
    required this.inventoryPurchaseTrx,
    required this.inventoryAllocationTrx,
  });

  final shopName = 'Smiling Tailor';
  final shopEmail = 'smilingtailor@algoramming.com';
  final shopAddress =
      'House #12, Road #02, Merul Badda,\nAnandanagar, Gulshan-1212, Dhaka';
  final shopPhone = '+880 1400629698';

  DateFormat get pdfDateTimeFormat =>
      DateFormat('${dateFormates[1]} ${timeFormates[1]}');

  pw.Widget pdfHeader(String name) {
    return pw.Row(
      children: [
        pw.Text(
          '${name.capitalize} Copy - (${order.id})',
          style: pw.TextStyle(
            fontSize: 8.0,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Expanded(
          child: pw.Container(
            margin: const pw.EdgeInsets.only(left: 5.0),
            color: PdfColors.teal,
            height: 0.5,
          ),
        ),
      ],
    );
  }

  pw.Widget pdfFooter(_) {
    return pw.Column(
      children: [
        pw.Divider(
          borderStyle: pw.BorderStyle.solid,
          color: PdfColors.grey300,
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'System Generated Invoice - ${appSettings.getDateTimeFormat.format(DateTime.now())}',
              style: const pw.TextStyle(
                fontSize: 7.0,
                color: PdfColors.grey500,
              ),
            ),
            pw.Text(
              'Developed by Algoramming.',
              style: const pw.TextStyle(
                fontSize: 7.0,
                color: PdfColors.grey500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget pdfCompanyIntro() {
    return pw.Expanded(
      flex: 2,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          pw.Image(
            pw.MemoryImage(icon),
            height: 45,
            width: 45,
          ),
          pw.SizedBox(height: 1.5 * PdfPageFormat.mm),
          pw.Text(
            shopName,
            style: pw.TextStyle(
              fontSize: 12.5,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
          pw.Text(
            shopAddress,
            style: const pw.TextStyle(fontSize: 8.0),
          ),
          pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
          pw.Text(
            shopEmail,
            style: const pw.TextStyle(fontSize: 8.0),
          ),
          pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
          pw.Text(
            shopPhone,
            style: const pw.TextStyle(fontSize: 8.0),
          ),
        ],
      ),
    );
  }
}
