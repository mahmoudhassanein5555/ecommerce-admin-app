import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/message_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'product_attachment_card.dart';

class MessageBubble extends StatelessWidget {
  final MessageEntity message;
  final bool isSender;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    if (message.isProductAttachment) {
      return Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: ProductAttachmentCard(metaData: message.attachedMetaData),
      );
    }

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0.h),
        padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.0.h),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.45,
        ),
        decoration: BoxDecoration(
          color: isSender ? AppColors.chatGoldAccent : AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
            bottomLeft:
                isSender ? Radius.circular(12.r) : const Radius.circular(0),
            bottomRight:
                isSender ? const Radius.circular(0) : Radius.circular(12.r),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withValues(alpha: 0.08),
              spreadRadius: 1,
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: isSender ? AppColors.white : AppColors.black87,
                fontSize: 12.5.sp,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              message.timestamp.toDate().toString().length > 10
                  ? message.timestamp.toDate().toString().substring(11, 16)
                  : message.timestamp.toDate().toString(),
              style: TextStyle(
                color: isSender
                    ? AppColors.white.withValues(alpha: 0.7)
                    : AppColors.grey500,
                fontSize: 9.5.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
