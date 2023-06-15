import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../pocketbase/auth.store/helpers.dart';
import '../../../../shared/show_toast/timer.snackbar/show.timer.snackbar.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../../utils/logger/logger_helper.dart';
import '../../../transaction/enum/trx.type.dart';
import '../../../transaction/model/transaction.dart';
import '../../model/order.dart';
import '../../pdf/file.handle.dart';
import '../../pdf/sample.pdf.dart';

typedef OrderSlipNotifier = AutoDisposeAsyncNotifierProviderFamily<
    OrderSlipProvider, void, PktbsOrder>;

final orderSlipProvider = OrderSlipNotifier(OrderSlipProvider.new);

late List<PktbsTrx> _trxs;

late List<Map<String, dynamic>> _slipOptions;
late List<bool> _selectedSlipOptions;
late List<Map<String, dynamic>> _downloadOptions;
late List<bool> _selectedDownloadOptions;

class OrderSlipProvider
    extends AutoDisposeFamilyAsyncNotifier<void, PktbsOrder> {
  @override
  FutureOr build(arg) async {
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
        'title': 'Customer Copy',
        'subtitle': 'This copy is for customer',
        'img': 'assets/svgs/customer-copy.svg'
      },
      {
        'title': 'Cashier Copy',
        'subtitle': 'This copy is for cashier',
        'img': 'assets/svgs/cashier-copy.svg'
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
        'subtitle': 'Download the order slip as PDF',
        'img': 'assets/svgs/pdf-format.svg'
      },
      {
        'title': 'Print as Slip',
        'subtitle': 'Download the order slip as Slip',
        'img': 'assets/svgs/slip-format.svg'
      },
    ];
    _selectedDownloadOptions = [true, true];
  }

  List<PktbsTrx> get trxs => _trxs;

  List<PktbsTrx> get goodsTrxs => _trxs.where((e) => e.isGoods).toList();

  List<PktbsTrx> get nonGoodsTrxs => _trxs.where((e) => !e.isGoods).toList();

  List<PktbsTrx> get paymentTrxs =>
      _trxs.where((e) => e.fromType.isUser || e.toType.isUser).toList();

  PktbsTrx? get advanceTrx => _trxs.any((e) => e.isOrderAdvanceAmount)
      ? _trxs.firstWhere((e) => e.isOrderAdvanceAmount)
      : null;

  PktbsTrx? get tailorTrx => _trxs.any((e) => e.isOrderTailorCharge)
      ? _trxs.firstWhere((e) => e.isOrderTailorCharge)
      : null;

  PktbsTrx? get inventoryAllocationTrx =>
      _trxs.any((e) => e.isOrderInventoryAllocation)
          ? _trxs.firstWhere((e) => e.isOrderInventoryAllocation)
          : null;

  PktbsTrx? get inventoryPurchaseTrx =>
      _trxs.any((e) => e.isOrderInventoryPurchase)
          ? _trxs.firstWhere((e) => e.isOrderInventoryPurchase)
          : null;

  PktbsTrx? get deliveryTrx => _trxs.any((e) => e.isOrderDeliveryCharge)
      ? _trxs.firstWhere((e) => e.isOrderDeliveryCharge)
      : null;

  List<Map<String, dynamic>> get slipOptions => _slipOptions;

  List<bool> get selectedSlipOptions => _selectedSlipOptions;

  List<Map<String, dynamic>> get downloadOptions => _downloadOptions;

  List<bool> get selectedDownloadOptions => _selectedDownloadOptions;

  void toggleSlipOption(int index) {
    _selectedSlipOptions[index] = !_selectedSlipOptions[index];
    ref.notifyListeners();
  }

  void toggleDownloadOption(int index) {
    _selectedDownloadOptions[index] = !_selectedDownloadOptions[index];
    ref.notifyListeners();
  }

  void reset() {
    _trxs = [];
    _slipOptions = [];
    _selectedSlipOptions = [];
    _downloadOptions = [];
    _selectedDownloadOptions = [];
  }

  Future<void> submit(BuildContext context) async {
    log.i('Order Slip Submit===========================');
    log.i(arg);
    log.i('Order Slip Trxs: $trxs');
    log.i('Order Slip Goods Trxs: $goodsTrxs');
    log.i('Order Slip Non Goods Trxs: $nonGoodsTrxs');
    log.i('Order Slip Payment Trxs: $paymentTrxs');
    log.i('Order Slip Advance Trx: $advanceTrx');
    log.i('Order Slip Tailor Trx: $tailorTrx');
    log.i('Order Slip Inventory Allocation Trx: $inventoryAllocationTrx');
    log.i('Order Slip Inventory Purchase Trx: $inventoryPurchaseTrx');
    log.i('Order Slip Delivery Trx: $deliveryTrx');
    log.i('Order Slip Slip Options: $slipOptions');
    log.i('Order Slip Selected Slip Options: $selectedSlipOptions');
    log.i('Order Slip Download Options: $downloadOptions');
    log.i('Order Slip Selected Download Options: $selectedDownloadOptions');
    log.i('Order Slip Submit===========================');
    await PdfInvoiceApi.generate().then((file) async {
      context.pop();
      showTimerSnackbar(
        context,
        contentText: '${file.path.split('\\').last} generated)',
        buttonLabel: 'View',
        onTap: () async => await FileHandleApi.openFile(file),
      );
      log.i('Order Slip Submit===========================');
      log.i('PDF File Location: ${file.path}');
      log.i('Order Slip Submit===========================');
    });
  }
}
