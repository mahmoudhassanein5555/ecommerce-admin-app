import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_app/features/orders/domain/entity/order_entity.dart';

class OrderDto extends OrderEntity {
  OrderDto({
    required super.orderId,
    required super.userId,
    required super.totalAmount,
    required super.orderStatus,
    required super.orderDate,
    required super.items,
    required super.paymentId,
    required super.userName,
    required super.customerEmail,
    required super.customerPhone,
    required super.cardLastDigits,
    required super.subtotal,
    // required super.shippingFees,
    // required super.taxFees,
    required super.shippingAddress,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) {
    return OrderDto(
      orderId: json["orderId"]?.toString() ?? "",
      userId: json["userId"] is int
          ? json["userId"] as int
          : (int.tryParse(json["userId"]?.toString() ?? '') ?? 0),
      totalAmount: (json["totalAmount"] as num?)?.toDouble() ?? 0.0,
      orderStatus: json["orderStatus"]?.toString() ?? '',
      orderDate: json["orderDate"] != null && json["orderDate"] is Timestamp
          ? (json["orderDate"] as Timestamp).toDate()
          : (json["createdAt"] != null && json["createdAt"] is Timestamp
              ? (json["createdAt"] as Timestamp).toDate()
              : DateTime.now()),
      items: json["items"] != null && json["items"] is List
          ? (json["items"] as List<dynamic>)
              .map((e) => OrderItemDto.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      paymentId: json["paymentId"]?.toString() ?? '',
      userName: json["userName"]?.toString() ?? '',
      customerEmail: json["customerEmail"]?.toString() ?? '',
      customerPhone: json["customerPhone"]?.toString() ?? '',
      cardLastDigits: json["cardLastDigits"]?.toString() ?? '',
      subtotal: (json["subtotal"] as num?)?.toDouble() ?? 0.0,
      shippingAddress: json["shippingAddress"] != null &&
              json["shippingAddress"] is Map<String, dynamic>
          ? ShippingAddressDto.fromJson(
              json["shippingAddress"] as Map<String, dynamic>,
            )
          : ShippingAddressDto(
              street: '',
              city: '',
              state: '',
              zipCode: '',
              country: '',
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "userId": userId,
      "totalAmount": totalAmount,
      "orderStatus": orderStatus,
      "createdAt": Timestamp.fromDate(orderDate),
      "items": items.map((e) => (e as OrderItemDto).toJson()).toList(),
      "paymentId": paymentId,
      "userName": userName,
    };
  }
}

class ShippingAddressDto extends ShippingAddressEntity {
  ShippingAddressDto({
    required super.street,
    required super.city,
    required super.state,
    required super.zipCode,
    required super.country,
  });
  factory ShippingAddressDto.fromJson(Map<String, dynamic> json) {
    return ShippingAddressDto(
      street: json["street"]?.toString() ?? '',
      city: json["city"]?.toString() ?? '',
      state: json["state"]?.toString() ?? '',
      zipCode: json["zipCode"]?.toString() ?? '',
      country: json["country"]?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "street": street,
      "city": city,
      "state": state,
      "zipCode": zipCode,
      "country": country,
    };
  }
}

class OrderItemDto extends OrderItemEntity {
  OrderItemDto({
    required super.quantity,
    required super.price,
    required super.image,
    required super.productId,
    required super.productTitle,
    required super.sku,
  });

  factory OrderItemDto.fromJson(Map<String, dynamic> json) {
    return OrderItemDto(
      quantity: (json["quantity"] as num?)?.toInt() ?? 0,
      price: (json["price"] as num?)?.toDouble() ?? 0.0,
      image: json["image"]?.toString() ?? '',
      productId: json["productId"] is int
          ? json["productId"] as int
          : (int.tryParse(json["productId"]?.toString() ?? '') ?? 0),
      productTitle: json["productTitle"]?.toString() ?? '',
      sku: json["sku"]?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "quantity": quantity,
      "price": price,
      "image": image,
      "productId": productId,
      "productTitle": productTitle,
      "sku": sku,
    };
  }
}
