import 'package:flutter/material.dart';

enum UserType {
  superadmin('Super Admin', Colors.red),
  admin('Admin', Colors.red),
  manager('Manager', Colors.green),
  dispose('Dispose', Colors.black87);

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
      case 'Dispose':
        return UserType.dispose;
      default:
        return UserType.dispose;
    }
  }
}

extension UserTypeExtension on UserType {
  bool get isSuperAdmin => this == UserType.superadmin;

  bool get isAdmin => this == UserType.admin;

  bool get isManager => this == UserType.manager;

  bool get isDispose => this == UserType.dispose;

  bool get isNotSuperAdmin => this != UserType.superadmin;

  bool get isNotAdmin => this != UserType.admin;

  bool get isNotManager => this != UserType.manager;

  bool get isNotDispose => this != UserType.dispose;
}
