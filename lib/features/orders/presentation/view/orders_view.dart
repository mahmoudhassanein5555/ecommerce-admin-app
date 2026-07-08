import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/features/orders/domain/entity/order_entity.dart';
import 'package:ecommerce_admin_app/features/orders/presentation/view_model/orders_bloc.dart';
import 'package:ecommerce_admin_app/features/orders/presentation/view_model/orders_bloc_events.dart';
import 'package:ecommerce_admin_app/features/orders/presentation/view_model/orders_bloc_states.dart';
import 'package:ecommerce_admin_app/features/orders/presentation/widgets/orders_header.dart';
import 'package:ecommerce_admin_app/features/orders/presentation/widgets/orders_split_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  OrderEntity? _selectedOrder;

  @override
  initState() {
    super.initState();
    print("OrdersView initState called");
    print(
      "***************************************************************************************************",
    );
    context.read<OrdersBloc>().add(const GetOrdersEvent());
    print("OrdersView initState called");
  }

  // static const _orders = <OrderRowData>[
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OrdersHeader(),
              SizedBox(height: 28.h),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: BlocBuilder<OrdersBloc, OrdersState>(
                    builder: (context, state) {
                      if (state is OrdersLoading) {
                        return Center(
                          child: SizedBox(
                            width: 300.w,
                            height: 300.h,
                            child: Lottie.asset(
                              'assets/animations/loading.json',
                            ),
                          ),
                        );
                      }
                      if (state is OrdersError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                state.errorMessage,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.red,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              ElevatedButton.icon(
                                onPressed: () {
                                  context.read<OrdersBloc>().add(
                                    const GetOrdersEvent(),
                                  );
                                },
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  AppStrings.tryAgain,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.goldAccent,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                    vertical: 12.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is OrdersLoaded) {
                        final orders = state.orders;
                        return OrdersSplitScreen(
                          orders: orders,
                          selectedOrder: _selectedOrder,
                          onOrderSelected: (order) {
                            setState(() {
                              _selectedOrder = order;
                            });
                          },
                          onClearSelection: () {
                            setState(() {
                              _selectedOrder = null;
                            });
                          },
                        );
                      }
                      return const Center(
                        child: Text(AppStrings.noOrdersAvailable),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
