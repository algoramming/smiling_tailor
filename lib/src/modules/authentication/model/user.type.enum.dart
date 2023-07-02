import 'package:flutter/material.dart';

enum UserType {
  superadmin('Super Admin', Colors.red),
  admin('Admin', Colors.yellow),
  manager('Manager', Colors.green);

  const UserType(this.title, this.color);
  final String title;
  final Color color;
}

extension UserTypeStringExtension on String {
  UserType get toUserType {
    switch (this) {
      case 'Super Admin':
        return UserType.superadmin;
      case 'Admin':
        return UserType.admin;
      case 'Manager':
        return UserType.manager;
      default:
        return UserType.manager;
    }
  }
}

extension UserTypeExtension on UserType {
  bool get isSuperAdmin => this == UserType.superadmin;

  bool get isAdmin => this == UserType.admin;

  bool get isManager => this == UserType.manager;

  bool get isNotSuperAdmin => this != UserType.superadmin;

  bool get isNotAdmin => this != UserType.admin;

  bool get isNotManager => this != UserType.manager;
}
