import 'package:flutter/material.dart';

import '../../authentication/view/authentication.dart';
import '../../dashboard/dashboard.dart';
import '../../employee/view/employee.dart';
import '../../inventory/view/inventory.dart';
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
  addManager,
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
      case KDrawer.addManager:
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
      case KDrawer.addManager:
        return 'Add Manager';
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
      case KDrawer.addManager:
        return const AuthenticationView(isSignup: true);
      case KDrawer.settings:
        return const SettingsView();
      default:
        return const DashboardView();
    }
  }
}
