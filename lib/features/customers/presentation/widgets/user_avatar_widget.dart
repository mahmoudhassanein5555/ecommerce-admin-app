import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAvatarWidget extends StatelessWidget {
  final String imageUrl;
  final String fallbackName;
  final double size;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  const UserAvatarWidget({
    super.key,
    required this.imageUrl,
    required this.fallbackName,
    this.size = 40,
    this.border,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveSize = size.r;
    final initial = fallbackName.trim().isNotEmpty
        ? fallbackName.trim()[0].toUpperCase()
        : '?';

    return Container(
      width: effectiveSize,
      height: effectiveSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: border ?? Border.all(color: AppColors.borderLight),
        boxShadow: boxShadow,
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: AppColors.surfaceSoft,
            child: const Center(
              child: SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: AppColors.goldAccent,
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: const Color(0xFFF1ECE4),
            child: Center(
              child: Text(
                initial,
                style: TextStyle(
                  fontSize: (effectiveSize * 0.4).sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBrown,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
