import 'package:ecommerce_admin_app/features/orders/domain/entity/order_entity.dart';
import 'package:equatable/equatable.dart';

abstract class OrdersState extends Equatable {}

class OrdersInitial extends OrdersState {
  @override
  List<Object?> get props => [];
}

class OrdersLoading extends OrdersState {
  @override
  List<Object?> get props => [];
}

class OrdersLoaded extends OrdersState {
  final List<OrderEntity> orders;

  OrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrdersError extends OrdersState {
  final String errorMessage;

  OrdersError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
