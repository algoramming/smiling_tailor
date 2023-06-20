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

  String get imgPath {
    switch (this) {
      case OrderStatus.pending:
        return 'assets/svgs/pending-delivery.svg';
      case OrderStatus.processing:
        return 'assets/svgs/under-processing.svg';
      case OrderStatus.ready:
        return 'assets/svgs/ready-for-delivery.svg';
      case OrderStatus.shipping:
        return 'assets/svgs/out-for-delivery.svg';
      case OrderStatus.completed:
        return 'assets/svgs/completed.svg';
      case OrderStatus.cancelled:
        return 'assets/svgs/invoice.svg';
      default:
        return 'assets/svgs/pending-delivery.svg';
    }
  }

  bool get isPending => this == OrderStatus.pending;

  bool get isUnderProcessing => this == OrderStatus.processing;

  bool get isReadyForDelivery => this == OrderStatus.ready;

  bool get isOutForDelivery => this == OrderStatus.shipping;

  bool get isCompleted => this == OrderStatus.completed;

  bool get isCancelled => this == OrderStatus.cancelled;

  bool get isNotPending => this != OrderStatus.pending;

  bool get isNotUnderProcessing => this != OrderStatus.processing;

  bool get isNotReadyForDelivery => this != OrderStatus.ready;

  bool get isNotOutForDelivery => this != OrderStatus.shipping;

  bool get isNotCompleted => this != OrderStatus.completed;

  bool get isNotCancelled => this != OrderStatus.cancelled;
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
