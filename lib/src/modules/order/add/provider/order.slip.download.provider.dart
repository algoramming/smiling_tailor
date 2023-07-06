import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../db/db.dart';
import '../../../../pocketbase/auth.store/helpers.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../../utils/logger/logger_helper.dart';
import '../../../transaction/enum/trx.type.dart';
import '../../../transaction/model/transaction.dart';
import '../../model/order.dart';
import '../pdf/pdf.invoice.design/a.pdf.invoice.dart';
import '../view/order.slip.confirmation.popup.dart';

typedef OrderSlipDownloadNotifier = AutoDisposeAsyncNotifierProviderFamily<
    OrderSlipDownloadProvider, void, PktbsOrder>;

final orderSlipDownloadProvider =
    OrderSlipDownloadNotifier(OrderSlipDownloadProvider.new);

late List<PktbsTrx> _trxs;

late List<Map<String, dynamic>> _slipOptions;
late List<bool> _selectedSlipOptions;
late List<Map<String, dynamic>> _downloadOptions;
int _selectedDownloadOption = 0; // 0: PDF, 1: Slip

class OrderSlipDownloadProvider
    extends AutoDisposeFamilyAsyncNotifier<void, PktbsOrder> {
  @override
  FutureOr build(arg) async {
    // _trxs = (await ref.watch(allTrxsProvider.future))
    //     .where((e) => e.fromId == arg.id || e.toId == arg.id)
    //     .toList();
    _trxs = [];
    _trxs = await pb
        .collection(transactions)
        .getFullList(
          filter: '(from_id = "${arg.id}" || to_id = "${arg.id}")',
          expand: pktbsTrxExpand,
        )
        .then((v) {
      log.i('Order Slip Trxs: $v');
      return v.map((e) => PktbsTrx.fromJson(e.toJson())).toList();
    });
    _slipOptions = [
      {
        'title': 'Cashier Copy',
        'subtitle': 'This copy is for cashier',
        'img': 'assets/svgs/cashier-copy.svg'
      },
      {
        'title': 'Customer Copy',
        'subtitle': 'This copy is for customer',
        'img': 'assets/svgs/customer-copy.svg'
      },
      {
        'title': 'Tailor Copy',
        'subtitle': 'This copy is for tailor',
        'img': 'assets/svgs/tailor-copy.svg'
      },
    ];
    _selectedSlipOptions = [true, true, true];
    _downloadOptions = [
      {
        'title': 'Download as PDF',
        'warning': null,
        'subtitle': 'Download the order slip as PDF',
        'img': 'assets/svgs/pdf-format.svg'
      },
      {
        'title': 'Print as Slip',
        'warning': 'Currently unavailable!',
        'subtitle': 'Download the order slip as Slip',
        'img': 'assets/svgs/slip-format.svg'
      },
    ];
  }

  List<PktbsTrx> get trxs => _trxs;

  List<PktbsTrx> get goodsTrxs => _trxs.where((e) => e.isGoods).toList();

  List<PktbsTrx> get nonGoodsTrxs => _trxs.where((e) => !e.isGoods).toList();

  PktbsTrx? get advanceTrx => _trxs.any((e) => e.isOrderAdvanceAmount)
      ? _trxs.firstWhere((e) => e.isOrderAdvanceAmount)
      : null;

  List<PktbsTrx> get paymentOthersTrxs => _trxs
      .where((e) =>
          (e.fromType.isUser || e.toType.isUser) &&
          !e.isGoods &&
          !e.isOrderAdvanceAmount)
      .toList();

  PktbsTrx? get tailorTrx =>
      _trxs.any((e) => e.isOrderTailorCharge && !e.isGoods)
          ? _trxs.firstWhere((e) => e.isOrderTailorCharge && !e.isGoods)
          : null;

  PktbsTrx? get inventoryAllocationTrx =>
      _trxs.any((e) => e.isOrderInventoryAllocation && e.isGoods)
          ? _trxs.firstWhere((e) => e.isOrderInventoryAllocation && e.isGoods)
          : null;

  PktbsTrx? get inventoryPurchaseTrx =>
      _trxs.any((e) => e.isOrderInventoryPurchase && !e.isGoods)
          ? _trxs.firstWhere((e) => e.isOrderInventoryPurchase && !e.isGoods)
          : null;

  PktbsTrx? get deliveryTrx =>
      _trxs.any((e) => e.isOrderDeliveryCharge && !e.isGoods)
          ? _trxs.firstWhere((e) => e.isOrderDeliveryCharge && !e.isGoods)
          : null;

  List<Map<String, dynamic>> get slipOptions => _slipOptions;

  List<bool> get selectedSlipOptions => _selectedSlipOptions;

  List<Map<String, dynamic>> get downloadOptions => _downloadOptions;

  int get selectedDownloadOption => _selectedDownloadOption;

  bool get isAllSlipUnselected => _selectedSlipOptions.every((e) => !e);

  void toggleSlipOption(int index) {
    _selectedSlipOptions[index] = !_selectedSlipOptions[index];
    ref.notifyListeners();
  }

  void toggleDownloadOption(int i) {
    if (i == 1) return;
    _selectedDownloadOption = i;
    ref.notifyListeners();
  }

  void reset() {
    _trxs = [];
    _slipOptions = [];
    _selectedSlipOptions = [];
    _downloadOptions = [];
    _selectedDownloadOption = 0;
  }

  Future<void> submit(BuildContext context) async {
    if (isAllSlipUnselected) return;
    log.i('Order Slip Submit===========================');
    log.i(arg);
    log.i('Order Slip Trxs: $trxs');
    log.i('Order Slip Goods Trxs: $goodsTrxs');
    log.i('Order Slip Non Goods Trxs: $nonGoodsTrxs');
    log.i('Order Slip Payment Others Trxs: $paymentOthersTrxs');
    log.i('Order Slip Advance Trx: $advanceTrx');
    log.i('Order Slip Tailor Trx: $tailorTrx');
    log.i('Order Slip Inventory Allocation Trx: $inventoryAllocationTrx');
    log.i('Order Slip Inventory Purchase Trx: $inventoryPurchaseTrx');
    log.i('Order Slip Delivery Trx: $deliveryTrx');
    log.i('Order Slip Options: $slipOptions');
    log.i('Order Slip Selected Slip Options: $selectedSlipOptions');
    log.i('Order Slip Download Options: $downloadOptions');
    log.i('Order Slip Selected Download Options: $selectedDownloadOption');
    log.i('Order Slip Submit===========================');

    await _print().then((p) async {
      context.pop();
      await showOrderSlipSharePopup(context, p);
      log.i('Order Slip Submit===========================');
    });
  }

  Future<List<dynamic>> _print() async {
    EasyLoading.show(status: 'Please wait...');
    List<dynamic> files = [];
    final pdfInvoice = PdfInvoice(
      order: arg,
      icon: appIcon,
      tailorTrx: tailorTrx,
      advanceTrx: advanceTrx,
      deliveryTrx: deliveryTrx,
      paymentOthersTrxs: paymentOthersTrxs,
      inventoryPurchaseTrx: inventoryPurchaseTrx,
      inventoryAllocationTrx: inventoryAllocationTrx,
    );

    if (selectedDownloadOption == 0) {
      // Pdf Download
      if (selectedSlipOptions[0]) {
        // cashier copy
        files.add(await pdfInvoice.cashierPdf('cashier'));
      }
      if (selectedSlipOptions[1]) {
        // customer copy
        files.add(await pdfInvoice.customerPdf('customer'));
      }
      if (selectedSlipOptions[2]) {
        // tailor copy
        files.add(await pdfInvoice.tailorPdf('tailor'));
      }
    }
    if (selectedDownloadOption == 1) {
      // Slip Download
      if (selectedSlipOptions[0]) {
        // cashier copy
        files.add(await pdfInvoice.samplePdf('cashier-slip'));
      }
      if (selectedSlipOptions[1]) {
        // customer copy
        files.add(await pdfInvoice.samplePdf('customer-slip'));
      }
      if (selectedSlipOptions[2]) {
        // tailor copy
        files.add(await pdfInvoice.samplePdf('tailor-slip'));
      }
    }
    EasyLoading.dismiss();
    return files;
  }
}
