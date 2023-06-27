import 'package:smiling_tailor/src/modules/inventory/model/inventory.dart';
import 'package:smiling_tailor/src/modules/transaction/model/transaction.dart';

class InventoryTrx {
  final PktbsInventory inventory;
  final PktbsTrx? trx;

  InventoryTrx(this.inventory, this.trx);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InventoryTrx &&
        other.inventory.id == inventory.id &&
        other.trx?.id == trx?.id;
  }

  @override
  int get hashCode => (inventory.id.hashCode) ^ (trx?.id.hashCode ?? 0);
}
