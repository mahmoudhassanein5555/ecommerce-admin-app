import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_admin_app/features/orders/domain/entity/order_entity.dart';

class OrderListItem extends StatelessWidget {
  final OrderEntity order;

  const OrderListItem({super.key, required this.order});

  Color _paymentColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
      case 'delivered':
        return AppColors.paymentSuccess;
      case 'pending':
      case 'processing':
        return AppColors.paymentPending;
      case 'refunded':
      case 'cancelled':
        return AppColors.paymentCancelled;
      default:
        return AppColors.paymentDefault;
    }
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'shipped':
      case 'delivered':
        return AppColors.actionBlue;
      case 'processing':
        return AppColors.orderStatusPending;
      case 'cancelled':
        return AppColors.orderStatusHold;
      default:
        return AppColors.paymentDefault;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              order.orderId,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.textStrong,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.statusInitialBackground,
                  child: Text(
                    order.orderStatus.isNotEmpty
                        ? order.orderStatus[0].toUpperCase()
                        : '',
                    style: const TextStyle(
                      color: AppColors.statusInitialText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '\$${order.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textStrong,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _paymentColor(
                    order.orderStatus,
                  ).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  order.orderStatus,
                  style: TextStyle(
                    color: _paymentColor(order.orderStatus),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _statusColor(
                    order.orderStatus,
                  ).withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  order.orderStatus,
                  style: TextStyle(
                    color: _statusColor(order.orderStatus),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const SizedBox(
            width: 84,
            child: Icon(Icons.more_horiz, color: AppColors.moreIcon),
          ),
        ],
      ),
    );
  }
}
