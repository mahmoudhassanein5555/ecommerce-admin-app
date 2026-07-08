import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_app/features/orders/data/data_source/orders_data_source.dart';
import 'package:ecommerce_admin_app/features/orders/data/model/order_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OrdersDataSource)
class OrdersDataSourceImp implements OrdersDataSource {
  final FirebaseFirestore _firestore;

  OrdersDataSourceImp(this._firestore);

  @override
  Stream<List<OrderDto>> getOrders() {
    return _firestore
        .collection("orders")
        .orderBy("orderDate", descending: true)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => OrderDto.fromJson(doc.data()))
              .toList(),
        );
  }
}
