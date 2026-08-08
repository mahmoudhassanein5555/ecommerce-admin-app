import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/message_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductAttachmentCard extends StatelessWidget {
  final AttachedMetaDataEntity? metaData;
  const ProductAttachmentCard({super.key, this.metaData});

  @override
  Widget build(BuildContext context) {
    final title = metaData?.productTitle.isNotEmpty == true
        ? metaData!.productTitle
        : AppStrings.defaultProductAttachmentTitle;
    final price = metaData != null && metaData!.productPrice > 0
        ? '\$${metaData!.productPrice}'
        : r'$199.99';
    final imageUrl = metaData?.productImageUrl.isNotEmpty == true &&
            metaData!.productImageUrl.startsWith('http')
        ? metaData!.productImageUrl
        : 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400';

    return Container(
      width: 220.w,
      margin: EdgeInsets.symmetric(vertical: 4.0.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
            child: Image.network(
              imageUrl,
              height: 110.h,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 110.h,
                color: AppColors.grey200,
                child: Icon(Icons.image, size: 32.r, color: AppColors.grey),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  price,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                    color: AppColors.chatGoldAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
