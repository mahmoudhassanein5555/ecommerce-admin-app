import 'package:equatable/equatable.dart';

abstract class OrdersEvent with Equatable {
  const OrdersEvent();
  @override
  List<Object?> get props => [];
}

class GetOrdersEvent extends OrdersEvent {
  const GetOrdersEvent();
}
