import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../db/db.dart';
import '../../../pocketbase/auth.store/helpers.dart';
import '../../../utils/logger/logger_helper.dart';
import '../../transaction/api/trx.api.dart';
import '../../transaction/enum/trx.type.dart';
import '../model/vendor.dart';

typedef VendorNotifier
    = AsyncNotifierProvider<VendorProvider, List<PktbsVendor>>;

final vendorProvider = VendorNotifier(VendorProvider.new);

class VendorProvider extends AsyncNotifier<List<PktbsVendor>> {
  final refreshController = RefreshController(initialRefresh: false);
  TextEditingController searchCntrlr = TextEditingController();
  late List<PktbsVendor> _vendors;
  PktbsVendor? selectedVendor;

  int page = 1;
  int perPage = 20;

  @override
  FutureOr<List<PktbsVendor>> build() async {
    _vendors = [];
    _listener();
    _stream();
    _vendors = await _getList();
    return _vendors;
  }

  Future<List<PktbsVendor>> _getList([String? q]) async {
    return await pb
        .collection(vendors)
        .getList(
          page: page,
          perPage: perPage,
          sort: 'created',
          filter: q == null
              ? null
              : 'name >= "$q" || email >= "$q" || phone >= "$q"',
          expand: pktbsVendorExpand,
        )
        .then((v) {
      log.i('Vendors: $v');
      return v.items.map((e) => PktbsVendor.fromJson(e.toJson())).toList();
    });
  }

  _listener() => searchCntrlr.addListener(() async {
        final q = searchCntrlr.text;
        if (q.isNotEmpty || q.length < 3) return;
        page = 1;
        _vendors = q.isEmpty ? await _getList() : await _getList(q);
        ref.notifyListeners();
      });

  Future<void> refresh() async {
    page = 1;
    final repos = await _getList(searchCntrlr.text);
    if (repos.isNotEmpty) _vendors = repos;
    refreshController.refreshCompleted();
    ref.notifyListeners();
  }

  Future<void> loadMore() async {
    page++;
    final repos = await _getList(searchCntrlr.text);
    if (repos.isNotEmpty) _vendors.addAll(repos);
    refreshController.loadComplete();
    ref.notifyListeners();
  }

  _stream() {
    pb.collection(vendors).subscribe(
      '*',
      expand: pktbsVendorExpand,
      // filter: 'name >= "$q" || email >= "$q" || phone >= "$q"',
      (s) async {
        log.i('Stream $s');
        if (s.action == 'delete') {
          _vendors.removeWhere((e) => e.id == s.record!.toJson()['id']);
        } else if (s.action == 'update') {
          _vendors.removeWhere((e) => e.id == s.record!.toJson()['id']);
          _vendors.add(PktbsVendor.fromJson(s.record!.toJson()));
        } else if (s.action == 'create') {
          _vendors.add(PktbsVendor.fromJson(s.record!.toJson()));
        } else {
          log.e('Unknown action: ${s.action}');
        }
        ref.notifyListeners();
      },
    );
  }

  List<PktbsVendor> get vendorList => _vendors;

  void selectVendor(PktbsVendor vendor) {
    selectedVendor = vendor;
    ref.notifyListeners();
  }

  Future<void> createDummy(BuildContext context, [int d = 50]) async {
    try {
      int i = 0;
      while (i < d) {
        EasyLoading.show();
        await pb.collection(vendors).create(
          body: {
            'name': 'Random Vendor ${Random().nextInt(1000)}-$i',
            'creator': pb.authStore.model!.id,
            'email': '${Random().nextInt(1000)}-$i@random.com',
            'phone': '0${Random().nextInt(99999)}${Random().nextInt(99999)}',
            'address': 'Random Address ${Random().nextInt(1000)}-$i',
            'description': 'Random Description ${Random().nextInt(1000)}-$i',
          },
          expand: pktbsVendorExpand,
        ).then((r) async {
          final openingBalance = Random().nextDouble();
          final ven = PktbsVendor.fromJson(r.toJson());
          final randBool = Random().nextBool();
          log.i('Need Trx for ${ven.name} of $openingBalance}');
          await pktbsAddTrx(
            context,
            fromId: pb.authStore.model?.id,
            fromJson: pb.authStore.model?.toJson(),
            fromType: GLType.user,
            toId: ven.id,
            toJson: ven.toJson(),
            toType: ven.glType,
            trxType: randBool ? TrxType.debit : TrxType.credit,
            isSystemGenerated: true,
            amount: openingBalance,
            voucher: 'Vendor Opening Balance Transaction',
            description:
                'System Generated: Transaction for Opening Balance. ${ven.name} [${ven.id}] is ${!randBool ? 'Payable' : 'Receivable'} of ${appCurrency.symbol}$openingBalance. Liability ${randBool ? 'Credit/Increase' : 'Debit/Decrease'}.',
          );
        });
        i++;
      }
      EasyLoading.showSuccess('${i + 1} Dummy Vendors Created.');
    } on SocketException catch (e) {
      EasyLoading.showError('No Internet Connection. $e');
      return;
    } on ClientException catch (e) {
      log.e('Dummy Vendor Creation: $e');
      return;
    }
  }
}
