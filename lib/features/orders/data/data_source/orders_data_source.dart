import 'package:ecommerce_admin_app/features/orders/data/model/order_dto.dart';

abstract class OrdersDataSource {
  Stream<List<OrderDto>> getOrders();
}
