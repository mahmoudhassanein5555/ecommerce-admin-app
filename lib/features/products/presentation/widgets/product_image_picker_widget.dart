import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 🎯 الـ Import المريح للباكدج

class ProductImagePickerWidget extends StatelessWidget {
  final String label;
  final String subLabel;
  final Uint8List? imageBytes;
  final String? imageUrl;
  final bool isUpdateProduct;
  final Function(Uint8List bytes, String name) onImageSelected;
  final VoidCallback onImageRemoved;
  final double leftPadding;

  const ProductImagePickerWidget({
    super.key,
    required this.label,
    required this.subLabel,
    required this.imageBytes,
    required this.imageUrl,
    required this.isUpdateProduct,
    required this.onImageSelected,
    required this.onImageRemoved,
    required this.leftPadding,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage =
        (isUpdateProduct && imageUrl != null && imageUrl!.isNotEmpty) ||
        imageBytes != null;

    return hasImage
        ? AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(40.r),
              child: Stack(
                children: [
                  imageBytes != null
                      ? Center(
                          child: Image.memory(imageBytes!, fit: BoxFit.contain),
                        )
                      : Center(
                          child: CachedNetworkImage(
                            imageUrl: imageUrl!,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1.r,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error, size: 20.r),
                          ),
                        ),

                  Positioned(
                    left: leftPadding.w,
                    child: IconButton(
                      icon: Icon(
                        Icons.system_update_alt_rounded,
                        color: AppColors.goldAccent,
                        size: 20.r,
                      ),
                      onPressed: () => _pickFile(),
                    ),
                  ),

                  Positioned(
                    right: 10.w,
                    top: 10.h,
                    child: CircleAvatar(
                      backgroundColor: AppColors.black.withOpacity(0.5),
                      radius: 14.r,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.close,
                          color: AppColors.white,
                          size: 16.r,
                        ),
                        onPressed: onImageRemoved,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20.h),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.grey.shade300,
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: const BoxDecoration(
                    color: AppColors.loaderBackground,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.cloud_upload_outlined,
                      color: AppColors.iconSlateGray,
                      size: 20.r,
                    ),
                    onPressed: () => _pickFile(),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDarkSlate,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subLabel,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          );
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result != null && result.files.first.bytes != null) {
      onImageSelected(result.files.first.bytes!, result.files.first.name);
    }
  }
}
