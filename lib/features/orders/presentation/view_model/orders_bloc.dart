import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/orders/domain/entity/order_entity.dart';
import 'package:ecommerce_admin_app/features/orders/domain/use_case/get_orders_use_case.dart';
import 'package:ecommerce_admin_app/features/orders/presentation/view_model/orders_bloc_events.dart';
import 'package:ecommerce_admin_app/features/orders/presentation/view_model/orders_bloc_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;
  OrdersBloc(this._getOrdersUseCase) : super(OrdersInitial()) {
    on<GetOrdersEvent>((event, emit) async {
      emit(OrdersLoading());

      await emit.forEach<Either<Failure, List<OrderEntity>>>(
        _getOrdersUseCase.invoke(),
        onData: (either) => either.fold(
          (failure) {
            return OrdersError(failure.failuremessage);
          },
          (orders) {
            return OrdersLoaded(orders);
          },
        ),
        onError: (error, stackTrace) {
          return OrdersError(error.toString());
        },
      );
    });
  }
}
