class OrderEntity {
  final String orderId;
  final int userId;
  final String userName;
  final String customerEmail; 
  final String customerPhone; 
  final String paymentId;
  final String cardLastDigits; 
  final double subtotal;
  final double totalAmount;
  final String orderStatus;
  final DateTime orderDate;
  final ShippingAddressEntity shippingAddress; 
  final List<OrderItemEntity> items;

  OrderEntity({
    required this.orderId,
    required this.userId,
    required this.userName,
    required this.customerEmail,
    required this.customerPhone,
    required this.paymentId,
    required this.cardLastDigits,
    required this.subtotal,
    required this.totalAmount,
    required this.orderStatus,
    required this.orderDate,
    required this.shippingAddress,
    required this.items,
  });
}

class ShippingAddressEntity {
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;

  ShippingAddressEntity({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  });
}

class OrderItemEntity {
  final int productId;
  final String productTitle;
  final String sku; 
  final String image;
  final double price;
  final int quantity;

  OrderItemEntity({
    required this.productId,
    required this.productTitle,
    required this.sku,
    required this.image,
    required this.price,
    required this.quantity,
  });
}