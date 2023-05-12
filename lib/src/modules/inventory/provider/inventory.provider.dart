import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef InventoryNotifier = NotifierProvider<InventoryProvider, void>;

final inventoryProvider = InventoryNotifier(InventoryProvider.new);

class InventoryProvider extends Notifier {
  @override
  void build() {}
}
