import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/core/di/servicelocator.dart';
import 'package:ecommerce_admin_app/core/utils/shared_prefs_local_data_source.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/message_entity.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/view_model/chats_bloc.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/view_model/chats_event.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/widgets/product_selection_dialog.dart';
import 'package:ecommerce_admin_app/features/products/domain/entites/products_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatInputField extends StatefulWidget {
  final String chatRoomId;

  const ChatInputField({super.key, required this.chatRoomId});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  late final TextEditingController _messageController;
  ProductsEntity? _selectedProduct;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _openProductDialog() async {
    final product = await ProductSelectionDialog.show(context);
    if (product != null) {
      setState(() {
        _selectedProduct = product;
      });
    }
  }

  void _sendMessage() {
    final text = _messageController.text.trim();

    if (text.isEmpty && _selectedProduct == null) {
      return;
    }

    final String name =
        getIt<CacheHelper>().getData(key: 'name')?.toString() ??
        AppStrings.defaultAdminName;
    final String id =
        getIt<CacheHelper>().getData(key: "id")?.toString() ??
        AppStrings.defaultAdminId;

    final MessageEntity message;

    if (_selectedProduct != null) {
      final product = _selectedProduct!;
      final imageUrl = product.images.isNotEmpty ? product.images.first : '';

      message = MessageEntity(
        senderName: name,
        senderId: id,
        text: text.isNotEmpty ? text : product.title,
        timestamp: Timestamp.now(),
        isProductAttachment: true,
        isAdminSender: true,
        attachedMetaData: AttachedMetaDataEntity(
          productTitle: product.title,
          productPrice: product.price,
          productImageUrl: imageUrl,
          attachedId: product.id.toString(),
        ),
      );
    } else {
      message = MessageEntity(
        senderName: name,
        senderId: id,
        text: text,
        timestamp: Timestamp.now(),
        isProductAttachment: false,
        isAdminSender: true,
      );
    }

    context.read<ChatsBloc>().add(
      SendMessageEvent(message, chatRoomId: widget.chatRoomId),
    );

    _messageController.clear();
    setState(() {
      _selectedProduct = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.chatBorder)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_selectedProduct != null) ...[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0.w,
                vertical: 6.0.h,
              ),
              margin: EdgeInsets.fromLTRB(10.0.w, 8.0.h, 10.0.w, 0),
              decoration: BoxDecoration(
                color: AppColors.chatAttachmentBg,
                borderRadius: BorderRadius.circular(8.0.r),
                border: Border.all(
                  color: AppColors.chatGoldAccent.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(6.0.r),
                      border: Border.all(color: AppColors.grey300),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: _selectedProduct!.images.isNotEmpty &&
                            _selectedProduct!.images.first.startsWith('http')
                        ? CachedNetworkImage(
                            imageUrl: _selectedProduct!.images.first,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Icon(
                              Icons.image_outlined,
                              color: AppColors.grey,
                              size: 18.r,
                            ),
                          )
                        : Icon(
                            Icons.shopping_bag_outlined,
                            color: AppColors.chatGoldAccent,
                            size: 18.r,
                          ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 1.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.chatGoldAccent,
                                borderRadius: BorderRadius.circular(3.r),
                              ),
                              child: Text(
                                AppStrings.attachedProductLabel,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 8.5.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              '\$${_selectedProduct!.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.chatGoldAccent,
                                fontSize: 11.5.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          _selectedProduct!.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                            color: AppColors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 16.r,
                      color: AppColors.grey,
                    ),
                    visualDensity: VisualDensity.compact,
                    tooltip: AppStrings.removeAttachmentTooltip,
                    onPressed: () {
                      setState(() {
                        _selectedProduct = null;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 8.0.h),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    _selectedProduct != null ? Icons.attach_file : Icons.add,
                    color: _selectedProduct != null
                        ? AppColors.chatGoldAccent
                        : AppColors.grey,
                    size: 20.r,
                  ),
                  visualDensity: VisualDensity.compact,
                  tooltip: AppStrings.attachProductTooltip,
                  onPressed: _openProductDialog,
                ),
                IconButton(
                  icon: Icon(
                    Icons.emoji_emotions_outlined,
                    color: AppColors.grey,
                    size: 20.r,
                  ),
                  visualDensity: VisualDensity.compact,
                  onPressed: () {},
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    onSubmitted: (_) => _sendMessage(),
                    style: TextStyle(fontSize: 12.5.sp),
                    decoration: InputDecoration(
                      hintText: _selectedProduct != null
                          ? AppStrings.addNoteOrSendProductHint
                          : AppStrings.typeMessageHint,
                      hintStyle: TextStyle(
                        fontSize: 11.5.sp,
                        color: AppColors.grey500,
                      ),
                      filled: true,
                      fillColor: AppColors.chatBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.0.w,
                        vertical: 8.0.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                IconButton(
                  icon: Icon(Icons.send, size: 16.r),
                  color: AppColors.white,
                  visualDensity: VisualDensity.compact,
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.chatGoldAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.all(8.r),
                  ),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
