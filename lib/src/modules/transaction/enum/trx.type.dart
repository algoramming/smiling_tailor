import 'package:smiling_tailor/src/modules/vendor/model/vendor.dart';

import '../../employee/model/employee.dart';
import '../../inventory/model/inventory.dart';

enum GLType { vendor, employee, inventory, unknown }

extension GLTypeExt on GLType {
  String get title {
    switch (this) {
      case GLType.vendor:
        return 'Vendor';
      case GLType.employee:
        return 'Employee';
      case GLType.inventory:
        return 'Inventory';
      case GLType.unknown:
        return 'Unknown';
      default:
        return 'Unknown';
    }
  }
}

extension GLTypeStringExt on String {
  GLType get glType {
    switch (this) {
      case 'Vendor':
        return GLType.vendor;
      case 'Employee':
        return GLType.employee;
      case 'Inventory':
        return GLType.inventory;
      case 'Unknown':
        return GLType.unknown;
      default:
        return GLType.unknown;
    }
  }
}

extension GLTypeObjectExt on Object {
  GLType get glType {
    switch (this) {
      case PktbsVendor:
        return GLType.vendor;
      case PktbsEmployee:
        return GLType.employee;
      case PktbsInventory:
        return GLType.inventory;
      default:
        return GLType.unknown;
    }
  }
}
