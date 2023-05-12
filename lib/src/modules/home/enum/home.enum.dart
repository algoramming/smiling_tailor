import 'package:flutter/material.dart';

import '../../dashboard/dashboard.dart';
import '../../employee/employee.dart';
import '../../inventory/inventory.dart';
import '../../order/order.dart';
import '../../profile/profile.dart';

enum KDrawer { dashboard, profile, inventory, employee, orders }

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
      default:
        return '';
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
      default:
        return '';
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
      default:
        return const DashboardView();
    }
  }
}
