import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreSeeder {
  FirestoreSeeder._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final Random _random = Random();

  static final List<Map<String, String>> _customers = [
    {"name": "Alex Mercer", "email": "alex.mercer@email.com", "phone": "+1 (555) 0123-4567"},
    {"name": "Elena Rodriguez", "email": "elena.r@email.com", "phone": "+1 (555) 7654-3210"},
    {"name": "Marcus Thorne", "email": "marcus.t@email.com", "phone": "+1 (555) 8901-2345"},
    {"name": "Sarah Jenkins", "email": "sarah.j@email.com", "phone": "+1 (555) 4321-0987"},
  ];

  static final List<String> _statuses = ["Processing", "Shipped", "On Hold", "Cancelled"];

  static final List<Map<String, dynamic>> _products = [
    {"id": 1, "title": "Pro Voyager Backpack", "sku": "TR-902-B", "image": "https://picsum.photos/200?1", "price": 850.0},
    {"id": 2, "title": "Acoustic Pure Gen-2", "sku": "HD-441-S", "image": "https://picsum.photos/200?2", "price": 399.0},
    {"id": 3, "title": "MacBook Air M3", "sku": "MAC-M3-X", "image": "https://picsum.photos/200?3", "price": 1299.0},
  ];

  static final List<Map<String, String>> _addresses = [
    {"street": "742 Evergreen Terrace, Floor 4, Apt 12C", "city": "Seattle", "state": "WA", "zipCode": "98101", "country": "United States"},
    {"street": "123 Main Street, Apt 5B", "city": "New York", "state": "NY", "zipCode": "10001", "country": "United States"},
  ];

  static Future<void> generateOrders({int count = 5}) async {
    final batch = _firestore.batch();
    final ordersCollection = _firestore.collection("orders");

    for (int i = 0; i < count; i++) {
      final doc = ordersCollection.doc();
      final customer = _customers[_random.nextInt(_customers.length)];
      final status = _statuses[_random.nextInt(_statuses.length)];
      final address = _addresses[_random.nextInt(_addresses.length)];
      
      final itemCount = _random.nextInt(2) + 1;
      List<Map<String, dynamic>> itemsList = [];
      double subtotal = 0;

      for (int j = 0; j < itemCount; j++) {
        final product = _products[_random.nextInt(_products.length)];
        final quantity = _random.nextInt(2) + 1;
        final price = product["price"] as double;
        subtotal += price * quantity;

        itemsList.add({
          "productId": product["id"],
          "productTitle": product["title"],
          "sku": product["sku"], // ➔ حقل جديد
          "image": product["image"],
          "price": price,
          "quantity": quantity,
        });
      }

      double shippingFees = 25.0;
      double taxFees = (subtotal * 0.08).roundToDouble(); // 8% ضرائب زي الصورة
      double totalAmount = subtotal + shippingFees + taxFees;

      final now = DateTime.now();
      String orderId = "SB-${now.year}${_random.nextInt(9000) + 1000}";

      // ➔ الداتا الجديدة الشاملة اللي هتنزل في الفايربيز:
      batch.set(doc, {
        "orderId": orderId,
        "userId": _random.nextInt(9000) + 1000,
        "userName": customer["name"],
        "customerEmail": customer["email"], // ➔ حقل جديد
        "customerPhone": customer["phone"], // ➔ حقل جديد
        "orderStatus": status,
        "orderDate": Timestamp.fromDate(now),
        "subtotal": subtotal,               // ➔ حقل جديد
        "shippingFees": shippingFees,       // ➔ حقل جديد
        "taxFees": taxFees,                 // ➔ حقل جديد
        "totalAmount": totalAmount,
        "paymentId": "TXN_${_random.nextInt(900000) + 100000}",
        "cardLastDigits": "${_random.nextInt(9000) + 1000}", // ➔ حقل جديد
        "shippingAddress": address,          // ➔ حقل جديد (Map كامله)
        "items": itemsList,
      });
    }

    await batch.commit();
    print("🎯 Generated NEW orders with all required fields!");
  }
}