import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../utils/logger/logger_helper.dart';
import '../model/inventory.dart';

typedef InventoryNotifier
    = AsyncNotifierProvider<InventoryProvider, List<PktbsInventory>>;

final inventoryProvider = InventoryNotifier(InventoryProvider.new);

class InventoryProvider extends AsyncNotifier<List<PktbsInventory>> {
  final searchCntrlr = TextEditingController();
  PktbsInventory? selectedInventory;
  late List<PktbsInventory> _inventories;
  @override
  FutureOr<List<PktbsInventory>> build() async {
    _inventories = [];
    _listener();
    _stream();
    _inventories = await pb
        .collection(inventories)
        .getFullList(expand: pktbsInventoryExpand)
        .then((v) {
      log.i('Inventories: $v');
      return v.map((e) => PktbsInventory.fromJson(e.toJson())).toList();
    });

    return _inventories;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  _stream() {
    // Implement Stream needs pocketbase update to add filter and expand options then the autodispose had to remove
    pb.collection(inventories).subscribe('*', (s) async {
      log.i('Stream $s');
      await pb
          .collection(inventories)
          .getOne(s.record!.toJson()['id'], expand: pktbsInventoryExpand)
          .then((inven) {
        log.i('Stream After Get Inventory: $inven');
        if (s.action == 'create') {
          _inventories.add(PktbsInventory.fromJson(inven.toJson()));
        } else if (s.action == 'update') {
          _inventories.removeWhere((e) => e.id == inven.id);
          _inventories.add(PktbsInventory.fromJson(inven.toJson()));
        } else if (s.action == 'delete') {
          _inventories.removeWhere((e) => e.id == inven.id);
        }
        ref.notifyListeners();
      });
    });
  }

  List<PktbsInventory> get inventoryList {
    _inventories
        .sort((a, b) => b.created.toLocal().compareTo(a.created.toLocal()));
    final vs = _inventories;
    return vs
        .where((e) =>
            e.id.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.title.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.from.name
                .toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ||
            e.from.phone
                .toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ||
            e.creator.id
                .toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ||
            (e.updator?.id
                    .toLowerCase()
                    .contains(searchCntrlr.text.toLowerCase()) ??
                false) ||
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
