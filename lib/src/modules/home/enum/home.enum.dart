import 'package:flutter/material.dart';
import 'package:smiling_tailor/src/modules/settings/view/setting.view.dart';

import '../../dashboard/dashboard.dart';
import '../../employee/view/employee.dart';
import '../../inventory/view/inventory.dart';
import '../../order/view/order.dart';
import '../../profile/profile.dart';

enum KDrawer { dashboard, profile, inventory, employee, orders, settings }

extension KDrawerExtension on KDrawer {
  String get icon {
    switch (this) {
      case KDrawer.dashboard:
        return 'assets/svgs/dashboard.svg';
      case KDrawer.profile:
        return 'assets/svgs/profile.svg';
      case KDrawer.inventory:
        return 'assets/svgs/inventory.svg';
      case KDrawer.employee:
        return 'assets/svgs/employee.svg';
      case KDrawer.orders:
        return 'assets/svgs/order.svg';
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
      case KDrawer.inventory:
        return 'Inventories';
      case KDrawer.employee:
        return 'Employees';
      case KDrawer.orders:
        return 'Orders';
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
      case KDrawer.inventory:
        return const InventoryView();
      case KDrawer.employee:
        return const EmployeeView();
      case KDrawer.orders:
        return const OrderView();
      case KDrawer.settings:
        return const SettingsView();
      default:
        return const DashboardView();
    }
  }
}
