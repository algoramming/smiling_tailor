import 'package:flutter/material.dart';

enum UserType {
  admin('Admin', Colors.red),
  manager('Manager', Colors.orange),
  operate('Operator', Colors.green),
  dispose('Dispose', Colors.black87);

  const UserType(this.title, this.color);
  final String title;
  final Color color;
}

extension UserTypeStringExtension on String {
  UserType get toUserType {
    switch (this) {
      case 'Admin':
        return UserType.admin;
      case 'Manager':
        return UserType.manager;
      case 'Operator':
        return UserType.operate;
      case 'Dispose':
        return UserType.dispose;
      default:
        return UserType.dispose;
    }
  }
}

extension UserTypeExtension on UserType {

  bool get isAdmin => this == UserType.admin;

  bool get isManager => this == UserType.manager;

  bool get isOperator => this == UserType.operate;

  bool get isDispose => this == UserType.dispose;

  bool get isNotAdmin => this != UserType.admin;

  bool get isNotManager => this != UserType.manager;

  bool get isNotOperator => this != UserType.operate;

  bool get isNotDispose => this != UserType.dispose;
}
