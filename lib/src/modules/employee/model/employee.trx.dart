import '../../transaction/model/transaction.dart';

import 'employee.dart';

class EmployeeTrx {
  final PktbsEmployee employee;
  final PktbsTrx? trx;

  EmployeeTrx(this.employee, {this.trx});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EmployeeTrx &&
        other.employee.id == employee.id &&
        other.trx?.id == trx?.id;
  }

  @override
  int get hashCode => (employee.id.hashCode) ^ (trx?.id.hashCode ?? 0);
}
