import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/features/orders/domain/entity/order_entity.dart';
import 'package:ecommerce_admin_app/features/orders/presentation/widgets/customer_profile_card.dart';
import 'package:ecommerce_admin_app/features/orders/presentation/widgets/order_item_card.dart';
import 'package:ecommerce_admin_app/features/orders/presentation/widgets/payment_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce_admin_app/features/orders/presentation/widgets/download_receipt_pdf_widget.dart';

class OrderDetailPanel extends StatefulWidget {
  final OrderEntity order;
  final VoidCallback onBack;

  const OrderDetailPanel({
    super.key,
    required this.order,
    required this.onBack,
  });

  @override
  State<OrderDetailPanel> createState() => _OrderDetailPanelState();
}

class _OrderDetailPanelState extends State<OrderDetailPanel> {
  bool _isUpdating = false;

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _updateOrderStatus(String newStatus) async {
    if (_isUpdating) return;

    setState(() => _isUpdating = true);

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('orderId', isEqualTo: widget.order.orderId)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception('Order not found in Firestore');
      }

      await snapshot.docs.first.reference.update({'orderStatus': newStatus});

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order status updated to $newStatus'),
          backgroundColor: AppColors.orderStatusShipped,
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update order status'),
          backgroundColor: AppColors.orderStatusCancelled,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isUpdating = false);
      }
    }
  }

  Future<void> _showStatusPicker(BuildContext context) async {
    final selectedStatus = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        final statuses = [
          'Processing',
          'Shipped',
          'On Hold',
          'Cancelled',
          'Delivered',
        ];

        return AlertDialog(
          title: const Text('Update order status'),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 12.h,
          ),
          content: SizedBox(
            width: 260.w,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: statuses.length,
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemBuilder: (context, index) {
                final status = statuses[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(status),
                  onTap: () => Navigator.pop(dialogContext, status),
                );
              },
            ),
          ),
        );
      },
    );

    if (selectedStatus != null && mounted) {
      await _updateOrderStatus(selectedStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = widget.order.subtotal;
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    const shipping = 12.5;
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    final tax = (subtotal + shipping) * 0.08;
    final total = subtotal + shipping + tax;
    final email = widget.order.customerEmail;
    final phone = widget.order.customerPhone;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: widget.onBack,
                child: Container(
                  width: 35.w,
                  height: 35.w,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSoft,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    size: 22.w,
                    color: AppColors.textDarkSlate,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.order.orderId,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textStrong,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Text(
                          '${AppStrings.placedLabel} ${_formatDate(widget.order.orderDate)}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.iconSlate,
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Container(
                          width: 4.w,
                          height: 4.w,
                          decoration: const BoxDecoration(
                            color: AppColors.borderMuted,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Text(
                          '${widget.order.items.length} ${AppStrings.itemsLabel}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.iconSlate,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => downloadReceiptPdf(context, widget.order),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.actionBlue,
                      side: const BorderSide(color: AppColors.actionBlue),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: Text(
                      AppStrings.printReceipt,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.actionBlue,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: _isUpdating
                        ? null
                        : () => _showStatusPicker(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: _isUpdating
                        ? SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.white,
                            ),
                          )
                        : Text(
                            AppStrings.updateStatus,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 28.h),
          Text(
            AppStrings.orderItems,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textStrong,
            ),
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 16.w,
            runSpacing: 16.h,
            children: widget.order.items
                .map((item) => OrderItemCard(item: item))
                .toList(),
          ),
          SizedBox(height: 28.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PaymentSummaryCard(
                  subtotal: subtotal,
                  shipping: shipping,
                  tax: tax,
                  total: total,
                  paymentId: widget.order.paymentId,
                  cardLastDigits: widget.order.cardLastDigits,
                ),
              ),
              SizedBox(width: 20.w),
              SizedBox(
                width: 320.w,
                child: CustomerProfileCard(
                  customerName: widget.order.userName,
                  email: email,
                  phone: phone,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
