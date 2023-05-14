import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/vendor/model/vendor.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../utils/logger/logger_helper.dart';

typedef VendorNotifier
    = AutoDisposeAsyncNotifierProvider<VendorProvider, List<PktbsVendor>>;

final vendorProvider = VendorNotifier(VendorProvider.new);

class VendorProvider extends AutoDisposeAsyncNotifier<List<PktbsVendor>> {
  TextEditingController searchCntrlr = TextEditingController();
  late List<PktbsVendor> _vendors;
  @override
  FutureOr<List<PktbsVendor>> build() async {
    _vendors = [];
    _listener();
    _stream();
    _vendors = await pb.collection(vendors).getFullList().then((v) {
      log.i('Vendors: $v');
      return v.map((e) {
        log.wtf('Vendor: $e');
        return PktbsVendor.fromJson(e.toJson());
      }).toList();
    });

    return _vendors;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  _stream() {
    pb.collection(vendors).subscribe('*', (s) {
      log.i('Stream ${s.toJson()}');
      if (s.action == 'create') {
        _vendors.add(PktbsVendor.fromJson(s.record!.toJson()));
      } else if (s.action == 'update') {
        _vendors.removeWhere((e) => e.id == s.record!.id);
        _vendors.add(PktbsVendor.fromJson(s.record!.toJson()));
      } else if (s.action == 'delete') {
        _vendors.removeWhere((e) => e.id == s.record!.id);
      }
      ref.notifyListeners();
    });
  }

  List<PktbsVendor> get vendorList {
    _vendors.sort((a, b) => b.created.compareTo(a.created));
    final vs = _vendors;
    return vs
        .where((e) =>
            e.name.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.address.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.phone.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            (e.email?.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ??
                false))
        .toList();
  }
}
