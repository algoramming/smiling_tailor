import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef EmployeeNotifier = NotifierProvider<EmployeeProvider, void>;

final employeeProvider = EmployeeNotifier(EmployeeProvider.new);

class EmployeeProvider extends Notifier {
  @override
  void build() {}
}
