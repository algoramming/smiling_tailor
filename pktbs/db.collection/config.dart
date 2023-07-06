// class PktbsUser {
//   //
//   final String id;
//   final DateTime created;
//   DateTime? updated;
//   final String collectionId;
//   final String collectionName;
//   //
//   String name;
//   final String username;
//   final String email;
//   bool emailVisibility;
//   bool verified;
//   String? avatar;
//   UserType type; // enum UserType { admin, manager, operate, dispose }
// }

// class PktbsVendor {
//   //
//   final String id;
//   final DateTime created;
//   DateTime? updated;
//   final PktbsUser creator;
//   PktbsUser? updator;
//   final String collectionId;
//   final String collectionName;
//   //
//   String name;
//   String phone;
//   String? email;
//   String address;
//   // double openingBalance; -> only add a column in trx table for vendor.
//   // TrxType openingBalanceTrxType; // enum TrxType { debit, credit }
//   String description;
// }

// class PktbsInventory {
//   //
//   final String id;
//   final DateTime created;
//   DateTime? updated;
//   final PktbsUser creator;
//   PktbsUser? updator;
//   final String collectionId;
//   final String collectionName;
//   //
//   String title;
//   int quantity;
//   Measurement unit;
//   double amount;
//   // double advanceAmount; -> only add a column in trx table for inventory.
//   PktbsVendor from;
//   String? description;
// }

// class Measurement {
//   //
//   final String name;
//   final String symbol;
//   final String unitOf;
//   final String system;
// }

// class PktbsEmployee {
//   //
//   final String id;
//   final DateTime created;
//   DateTime? updated;
//   final PktbsUser creator;
//   PktbsUser? updator;
//   final String collectionId;
//   final String collectionName;
//   //
//   String name;
//   String phone;
//   String? email;
//   double salary;
//   String address;
//   String description;
// }

// class PktbsOrder {
//   //
//   final String id;
//   DateTime created;
//   DateTime? updated;
//   PktbsUser creator;
//   PktbsUser? updator;
//   String collectionId;
//   String collectionName;
//   //
//   String customerName;
//   String? customerEmail;
//   String customerPhone;
//   String? customerAddress;
//   String? customerNote;
//   //
//   String? measurement;
//   String? plate;
//   String? sleeve;
//   String? colar;
//   String? pocket;
//   String? button;
//   String? measurementNote;
//   int quantity;
//   //
//   PktbsEmployee? tailorEmployee;
//   // double tailorCharge;  -> only add a column in trx table for tailor.
//   String? tailorNote;
//   //
//   PktbsInventory? inventory;
//   // int? inventoryQuantity;
//   // String? inventoryUnit;
//   // double? inventoryPrice; -> only add a column in trx table for inventory.
//   String? inventoryNote;
//   //
//   PktbsEmployee? deliveryEmployee;
//   String? deliveryAddress;
//   // double? deliveryCharge; -> only add a column in trx table for delivery.
//   String? deliveryNote;
//   //
//   PaymentMethod paymentMethod; // enum PaymentMethod { cash, mfs, card, cheque, others }
//   String? paymentNote;
//   double vat;
//   double discount;
//   double amount; // total amount = tailorCharge + inventoryPrice + deliveryCharge + vat - discount
//   //
//   DateTime deliveryTime;
//   String? description;
//   OrderStatus status; // enum OrderStatus { pending, processing, ready, shipping, completed, cancelled }
// }

// class PktbsTrx {
//   //
//   final String id;
//   final DateTime created;
//   DateTime? updated;
//   final PktbsUser creator;
//   PktbsUser? updator;
//   final String collectionId;
//   final String collectionName;
//   //
//   String fromId;
//   GLType fromType; // enum GLType { vendor, inventory, employee, order, user }
//   Map<String, dynamic> from;
//   //
//   String toId;
//   GLType toType; // enum GLType { vendor, inventory, employee, order, user }
//   Map<String, dynamic> to;
//   //
//   double amount;
//   Measurement? unit;
//   bool isGoods;
//   TrxType trxType; // enum TrxType { debit, credit }
//   //
//   bool isActive;
//   String voucher;
//   bool isSystemGenerated;
//   String? description;
// }

// enum PaymentMethod { cash, mfs, card, cheque, others }

// enum OrderStatus { pending, processing, ready, shipping, completed, cancelled }

// enum GLType { vendor, inventory, employee, order, user }

// enum TrxType { debit, credit }

// enum UserType { admin, manager, operate, dispose }
