import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/orders/domain/entity/order_entity.dart';
import 'package:ecommerce_admin_app/features/orders/domain/repository/orders_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrdersUseCase {
  final OrdersRepo _ordersRepo;

  GetOrdersUseCase(this._ordersRepo);

  Stream<Either<Failure, List<OrderEntity>>> invoke() => _ordersRepo.getOrders();
}
