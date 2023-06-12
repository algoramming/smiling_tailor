import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../utils/logger/logger_helper.dart';
import '../model/vendor.dart';

typedef VendorNotifier
    = AsyncNotifierProvider<VendorProvider, List<PktbsVendor>>;

final vendorProvider = VendorNotifier(VendorProvider.new);

class VendorProvider extends AsyncNotifier<List<PktbsVendor>> {
  TextEditingController searchCntrlr = TextEditingController();
  PktbsVendor? selectedVendor;
  late List<PktbsVendor> _vendors;
  @override
  FutureOr<List<PktbsVendor>> build() async {
    _vendors = [];
    _listener();
    _stream();
    _vendors = await pb
        .collection(vendors)
        .getFullList(expand: pktbsVendorExpand)
        .then((v) {
      log.i('Vendors: $v');
      return v.map((e) => PktbsVendor.fromJson(e.toJson())).toList();
    });

    return _vendors;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  _stream() {
    // Implement Stream needs pocketbase update to add filter and expand options then the autodispose had to remove
    pb.collection(vendors).subscribe('*', (s) async {
      log.i('Stream $s');
      await pb
          .collection(vendors)
          .getOne(s.record!.toJson()['id'], expand: pktbsVendorExpand)
          .then((ven) {
        log.i('Stream After Get Vendor: $ven');
        if (s.action == 'create') {
          _vendors.add(PktbsVendor.fromJson(ven.toJson()));
        } else if (s.action == 'update') {
          _vendors.removeWhere((e) => e.id == ven.id);
          _vendors.add(PktbsVendor.fromJson(ven.toJson()));
        } else if (s.action == 'delete') {
          _vendors.removeWhere((e) => e.id == ven.id);
        }
        ref.notifyListeners();
      });
    });
  }

  List<PktbsVendor> get vendorList {
    _vendors.sort((a, b) => b.created.toLocal().compareTo(a.created.toLocal()));
    final vs = _vendors;
    return vs
        .where((e) =>
            e.id.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.name.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.address.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.phone.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.creator.id
                .toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ||
            (e.updator?.id
                    .toLowerCase()
                    .contains(searchCntrlr.text.toLowerCase()) ??
                false) ||
            (e.email?.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ??
                false))
        .toList();
  }

  void selectVendor(PktbsVendor vendor) {
    selectedVendor = vendor;
    ref.notifyListeners();
  }
}
