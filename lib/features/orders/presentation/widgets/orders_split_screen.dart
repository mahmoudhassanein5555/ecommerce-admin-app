import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/features/orders/domain/entity/order_entity.dart';
import 'package:ecommerce_admin_app/features/orders/presentation/widgets/order_detail_panel.dart';
import 'package:ecommerce_admin_app/features/orders/presentation/widgets/order_detail_placeholder.dart';
import 'package:ecommerce_admin_app/features/orders/presentation/widgets/order_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersSplitScreen extends StatelessWidget {
  final List<OrderEntity> orders;
  final OrderEntity? selectedOrder;
  final ValueChanged<OrderEntity> onOrderSelected;
  final VoidCallback onClearSelection;

  const OrdersSplitScreen({
    super.key,
    required this.orders,
    required this.selectedOrder,
    required this.onOrderSelected,
    required this.onClearSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.04),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: Text(
                    AppStrings.recentOrders,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textStrong,
                    ),
                  ),
                ),
                const Divider(height: 1, color: AppColors.divider),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    itemCount: orders.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return OrderSummaryCard(
                        order: order,
                        isSelected: selectedOrder?.orderId == order.orderId,
                        onTap: () => onOrderSelected(order),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 24.w),
        Expanded(
          flex: 7,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.04),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: selectedOrder == null
                ? const OrderDetailPlaceholder()
                : OrderDetailPanel(
                    order: selectedOrder!,
                    onBack: onClearSelection,
                  ),
          ),
        ),
      ],
    );
  }
}
