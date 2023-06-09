enum OrderStatus { pending, processing, ready, shipping, completed, cancelled }

extension OrderStatusExtension on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Under Processing';
      case OrderStatus.ready:
        return 'Ready for Delivery';
      case OrderStatus.shipping:
        return 'Out for Delivery';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Pending';
    }
  }
}

extension StringOrderStatusExtension on String {
  OrderStatus get toOrderStatus {
    switch (this) {
      case 'Pending':
        return OrderStatus.pending;
      case 'Under Processing':
        return OrderStatus.processing;
      case 'Ready for Delivery':
        return OrderStatus.ready;
      case 'Out for Delivery':
        return OrderStatus.shipping;
      case 'Completed':
        return OrderStatus.completed;
      case 'Cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }
}

enum PaymentMethod { cash, mfs, card, cheque, others }

extension PaymentMethodExtension on PaymentMethod {
  String get label {
    switch (this) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.mfs:
        return 'MFS (Mobile Financial Services)';
      case PaymentMethod.card:
        return 'Visa/Master/Credit Card';
      case PaymentMethod.cheque:
        return 'Cheque';
      case PaymentMethod.others:
        return 'Others';
      default:
        return 'Cash';
    }
  }
}

extension StringPaymentMethodExtension on String {
  PaymentMethod get toPaymentMethod {
    switch (this) {
      case 'Cash':
        return PaymentMethod.cash;
      case 'MFS (Mobile Financial Services)':
        return PaymentMethod.mfs;
      case 'Visa/Master/Credit Card':
        return PaymentMethod.card;
      case 'Cheque':
        return PaymentMethod.cheque;
      case 'Others':
        return PaymentMethod.others;
      default:
        return PaymentMethod.cash;
    }
  }
}
