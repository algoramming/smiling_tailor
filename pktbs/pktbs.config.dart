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
//   String? email;
//   String address;
//   String phone;
//   String description;
//   double salary;
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
//   String? description;
//   int quantity;
//   String unit;
//   double amount;
//   double advance;
//   PktbsVendor from;
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
//   PktbsEmployee tailorEmployee;
//   double tailorCharge;
//   String? tailorNote;
//   //
//   PktbsInventory? inventory;
//   int? inventoryQuantity;
//   String? inventoryUnit;
//   double? inventoryPrice;
//   String? inventoryNote;
//   //
//   bool isHomeDeliveryNeeded;
//   PktbsEmployee? deliveryEmployee;
//   String? deliveryAddress;
//   double? deliveryCharge;
//   String? deliveryNote;
//   //
//   PaymentMethod paymentMethod; // enum PaymentMethod { cash, mfs, card, cheque, others }
//   String? paymentNote;
//   double advanceAmount;
//   //
//   DateTime deliveryTime;
//   String? description;
//   OrderStatus status; // enum OrderStatus { pending, processing, ready, shipping, completed, cancelled }
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
//   String? email;
//   String address;
//   String phone;
//   String description;
//   double openingBalance;
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
//   String glId;
//   Map<String, dynamic> gl;
//   GLType type; // enum GLType {vendor, employee, inventory, unknown}
//   double amount;
//   double due;
//   String? description;
// }

// enum PaymentMethod { cash, mfs, card, cheque, others }

// enum OrderStatus { pending, processing, ready, shipping, completed, cancelled }

// enum GLType { vendor, employee, inventory, unknown }
