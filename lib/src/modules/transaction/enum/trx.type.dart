import 'package:smiling_tailor/src/modules/vendor/model/vendor.dart';

import '../../authentication/model/user.dart';
import '../../employee/model/employee.dart';
import '../../inventory/model/inventory.dart';
import '../../order/model/order.dart';

enum GLType { vendor, inventory, employee, order, user }

extension GLTypeExt on GLType {
  String get title {
    switch (this) {
      case GLType.vendor:
        return 'Vendor';
      case GLType.inventory:
        return 'Inventory';
      case GLType.employee:
        return 'Employee';
      case GLType.order:
        return 'Order';
      case GLType.user:
        return 'User';
      default:
        return 'User';
    }
  }

  bool get isVendor => this == GLType.vendor;

  bool get isInventory => this == GLType.inventory;

  bool get isEmployee => this == GLType.employee;

  bool get isOrder => this == GLType.order;

  bool get isUser => this == GLType.user;

  bool get isNotVendor => this != GLType.vendor;

  bool get isNotInventory => this != GLType.inventory;

  bool get isNotEmployee => this != GLType.employee;

  bool get isNotOrder => this != GLType.order;

  bool get isNotUser => this != GLType.user;
}

extension GLTypeStringExt on String {
  GLType get glType {
    switch (this) {
      case 'Vendor':
        return GLType.vendor;
      case 'Inventory':
        return GLType.inventory;
      case 'Employee':
        return GLType.employee;
      case 'Order':
        return GLType.order;
      case 'User':
        return GLType.user;
      default:
        return GLType.user;
    }
  }
}

extension GLTypeObjectExt on Object {
  GLType get glType {
    switch (this) {
      case PktbsVendor:
        return GLType.vendor;
      case PktbsInventory:
        return GLType.inventory;
      case PktbsEmployee:
        return GLType.employee;
      case PktbsOrder:
        return GLType.order;
      case PktbsUser:
        return GLType.user;
      default:
        return GLType.user;
    }
  }
}


enum TrxType { debit, credit }

extension TrxTypeExt on TrxType {
  String get title {
    switch (this) {
      case TrxType.debit:
        return 'Debit';
      case TrxType.credit:
        return 'Credit';
      default:
        return 'Debit';
    }
  }

  bool get isDebit => this == TrxType.debit;

  bool get isCredit => this == TrxType.credit;

  bool get isNotDebit => this != TrxType.debit;

  bool get isNotCredit => this != TrxType.credit;
}

extension TrxTypeStringExt on String {
  TrxType get trxType {
    switch (this) {
      case 'Debit':
        return TrxType.debit;
      case 'Credit':
        return TrxType.credit;
      default:
        return TrxType.credit;
    }
  }
}
