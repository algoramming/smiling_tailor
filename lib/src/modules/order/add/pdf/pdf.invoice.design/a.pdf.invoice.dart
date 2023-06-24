import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:smiling_tailor/src/modules/transaction/model/transaction.dart';

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
}
