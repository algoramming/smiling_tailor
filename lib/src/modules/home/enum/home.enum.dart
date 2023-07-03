import 'package:flutter/material.dart';

import '../../dashboard/view/dashboard.dart';
import '../../employee/view/employee.dart';
import '../../inventory/view/inventory.dart';
import '../../invoices/view/invoice.dart';
import '../../manager.config/view/manager.config.dart';
import '../../order/view/order.dart';
import '../../profile/view/profile.dart';
import '../../settings/view/setting.view.dart';
import '../../vendor/view/vendor.dart';

enum KDrawer {
  dashboard,
  profile,
  vendor,
  inventory,
  employee,
  order,
  invoice,
  managerConfig,
  settings
}

extension KDrawerExtension on KDrawer {
  String get icon {
    switch (this) {
      case KDrawer.dashboard:
        return 'assets/svgs/dashboard.svg';
      case KDrawer.profile:
        return 'assets/svgs/profile.svg';
      case KDrawer.vendor:
        return 'assets/svgs/vendor.svg';
      case KDrawer.inventory:
        return 'assets/svgs/inventory.svg';
      case KDrawer.employee:
        return 'assets/svgs/employee.svg';
      case KDrawer.order:
        return 'assets/svgs/order.svg';
      case KDrawer.invoice:
        return 'assets/svgs/invoice.svg';
      case KDrawer.managerConfig:
        return 'assets/svgs/url-config.svg';
      case KDrawer.settings:
        return 'assets/svgs/settings.svg';
      default:
        return 'assets/svgs/home.svg';
    }
  }

  String get title {
    switch (this) {
      case KDrawer.dashboard:
        return 'Dashboard';
      case KDrawer.profile:
        return 'Profile';
      case KDrawer.vendor:
        return 'Vendors';
      case KDrawer.inventory:
        return 'Inventories';
      case KDrawer.employee:
        return 'Employees';
      case KDrawer.order:
        return 'Orders';
      case KDrawer.invoice:
        return 'Invoices';
      case KDrawer.managerConfig:
        return 'Manager Config';
      case KDrawer.settings:
        return 'Settings';
      default:
        return 'Home';
    }
  }

  Widget get widget {
    switch (this) {
      case KDrawer.dashboard:
        return const DashboardView();
      case KDrawer.profile:
        return const ProfileView();
      case KDrawer.vendor:
        return const VendorView();
      case KDrawer.inventory:
        return const InventoryView();
      case KDrawer.employee:
        return const EmployeeView();
      case KDrawer.order:
        return const OrderView();
      case KDrawer.invoice:
        return const InvoiceView();
      case KDrawer.managerConfig:
        return const ManagerConfigView();
      case KDrawer.settings:
        return const SettingsView();
      default:
        return const DashboardView();
    }
  }

  bool get isDashboard => this == KDrawer.dashboard;

  bool get isProfile => this == KDrawer.profile;

  bool get isVendor => this == KDrawer.vendor;

  bool get isInventory => this == KDrawer.inventory;

  bool get isEmployee => this == KDrawer.employee;

  bool get isOrder => this == KDrawer.order;

  bool get isInvoice => this == KDrawer.invoice;

  bool get isManagerConfig => this == KDrawer.managerConfig;

  bool get isSettings => this == KDrawer.settings;

  bool get isNotDashboard => this != KDrawer.dashboard;

  bool get isNotProfile => this != KDrawer.profile;

  bool get isNotVendor => this != KDrawer.vendor;

  bool get isNotInventory => this != KDrawer.inventory;

  bool get isNotEmployee => this != KDrawer.employee;

  bool get isNotOrder => this != KDrawer.order;

  bool get isNotInvoice => this != KDrawer.invoice;

  bool get isNotManagerConfig => this != KDrawer.managerConfig;

  bool get isNotSettings => this != KDrawer.settings;
}
