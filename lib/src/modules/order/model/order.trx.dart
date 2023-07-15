import '../../transaction/model/transaction.dart';
import 'order.dart';

class OrderTrx {
  final PktbsOrder order;
  final PktbsTrx? trx;

  OrderTrx(this.order, {this.trx});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrderTrx &&
        other.order.id == order.id &&
        other.trx?.id == trx?.id;
  }

  @override
  int get hashCode => (order.id.hashCode) ^ (trx?.id.hashCode ?? 0);
}
