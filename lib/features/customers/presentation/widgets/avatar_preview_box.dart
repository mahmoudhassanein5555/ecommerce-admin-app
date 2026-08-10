import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarPreviewBox extends StatelessWidget {
  final String avatarUrl;

  const AvatarPreviewBox({
    super.key,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final url = avatarUrl.trim();
    final isValidUrl = url.startsWith('http://') || url.startsWith('https://');

    return Container(
      width: 48.r,
      height: 48.r,
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: isValidUrl
            ? CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const Icon(
                  Icons.broken_image,
                  size: 22,
                  color: AppColors.iconGrey,
                ),
                placeholder: (_, __) => const Center(
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.goldAccent,
                    ),
                  ),
                ),
              )
            : const Icon(
                Icons.person,
                size: 24,
                color: AppColors.iconGrey,
              ),
      ),
    );
  }
}
