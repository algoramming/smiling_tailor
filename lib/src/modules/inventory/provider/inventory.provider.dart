import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/inventory/model/inventory.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../utils/logger/logger_helper.dart';

typedef InventoryNotifier
    = AsyncNotifierProvider<InventoryProvider, List<PktbsInventory>>;

final inventoryProvider = InventoryNotifier(InventoryProvider.new);

class InventoryProvider extends AsyncNotifier<List<PktbsInventory>> {
  TextEditingController searchCntrlr = TextEditingController();
  PktbsInventory? selectedInventory;
  late List<PktbsInventory> _inventories;
  @override
  FutureOr<List<PktbsInventory>> build() async {
    _inventories = [];
    _listener();
    _stream();
    _inventories = await pb.collection(inventories).getFullList(expand: 'created_by, updated_by, created_from').then((v) {
      log.i('Inventories: $v');
      return v.map((e) {
        log.wtf('Inventory: $e');
        return PktbsInventory.fromJson(e.toJson());
      }).toList();
    });

    return _inventories;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  _stream() {
    pb.collection(inventories).subscribe('*', (s) {
      log.i('Stream ${s.toJson()}');
      if (s.action == 'create') {
        _inventories.add(PktbsInventory.fromJson(s.record!.toJson()));
      } else if (s.action == 'update') {
        _inventories.removeWhere((e) => e.id == s.record!.id);
        _inventories.add(PktbsInventory.fromJson(s.record!.toJson()));
      } else if (s.action == 'delete') {
        _inventories.removeWhere((e) => e.id == s.record!.id);
      }
      ref.notifyListeners();
    });
  }

  List<PktbsInventory> get inventoryList {
    _inventories.sort((a, b) => b.created.compareTo(a.created));
    final vs = _inventories;
    return vs
        .where((e) =>
            e.title.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.createdFrom.name
                .toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ||
            e.createdFrom.phone
                .toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ||
            (e.description
                    ?.toLowerCase()
                    .contains(searchCntrlr.text.toLowerCase()) ??
                false))
        .toList();
  }

  void selectInventory(PktbsInventory inventory) {
    selectedInventory = inventory;
    ref.notifyListeners();
  }
}
