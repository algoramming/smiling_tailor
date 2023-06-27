import '../../transaction/model/transaction.dart';
import 'vendor.dart';

class VendorTrx {
  final PktbsVendor vendor;
  final PktbsTrx? trx;

  VendorTrx(this.vendor, {this.trx});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VendorTrx &&
        other.vendor.id == vendor.id &&
        other.trx?.id == trx?.id;
  }

  @override
  int get hashCode => (vendor.id.hashCode) ^ (trx?.id.hashCode ?? 0);
}