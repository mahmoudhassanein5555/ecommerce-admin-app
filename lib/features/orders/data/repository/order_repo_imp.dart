import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/errors/error_handler.dart'; 
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/orders/data/data_source/orders_data_source.dart';
import 'package:ecommerce_admin_app/features/orders/domain/entity/order_entity.dart';
import 'package:ecommerce_admin_app/features/orders/domain/repository/orders_repo.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OrdersRepo)
class OrderRepoImp implements OrdersRepo {
  final OrdersDataSource _ordersDataSource;

  OrderRepoImp(this._ordersDataSource);

  @override
  Stream<Either<Failure, List<OrderEntity>>> getOrders() async* {
    try {
      await for (final ordersDto in _ordersDataSource.getOrders()) {
        // Convert List<OrderDto> to List<OrderEntity>
        final orders = ordersDto.map<OrderEntity>((e) => e).toList();
        yield right(orders);
      }
    } catch (error) {
      debugPrint('💥💥 OrderRepoImp Stream Error: $error');
      debugPrint('📚 StackTrace: error 1');
      yield left<Failure, List<OrderEntity>>(ErrorHandler.handle(error));
    }
  }
}
