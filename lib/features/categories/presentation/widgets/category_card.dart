import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/core/dialogs/app_dialogs.dart';
import 'package:ecommerce_admin_app/features/categories/domain/entites/category_entity.dart';
import 'package:ecommerce_admin_app/features/categories/presentation/view_model/categories_bloc.dart';
import 'package:ecommerce_admin_app/features/categories/presentation/view_model/categories_event.dart';
import 'package:ecommerce_admin_app/features/categories/presentation/widgets/category_properties_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCard extends StatefulWidget {
  final CategoryEntity category;

  const CategoryCard({super.key, required this.category});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool cardIsHovered = false;
  bool editIconIsHovered = false;
  bool deleteIconIsHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => cardIsHovered = true),
      onExit: (_) => setState(() => cardIsHovered = false),
      child: GestureDetector(
        onTap: () {
          context.read<CategoriesBloc>().add(
            GetProductsByCategoryEvent(widget.category.id),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.identity()..translate(0, cardIsHovered ? -4 : 0),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.05),
                blurRadius: cardIsHovered ? 25.r : 8.r,
                spreadRadius: cardIsHovered ? 8.r : 0,
                offset: Offset(0, cardIsHovered ? 25.h : 4.h),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: widget.category.image.isEmpty
                      ? const _ImagePlaceholder()
                      : CachedNetworkImage(
                          imageUrl: widget.category.image,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1.r,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.categoryAccent,
                              ),
                              backgroundColor:
                                  AppColors.categoryAccentBackground,
                              strokeCap: StrokeCap.square,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error, size: 20.r),
                        ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0.w,
                      vertical: 14.0.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.category.name,
                                style: TextStyle(
                                  color: AppColors.textDarkSlate,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            MouseRegion(
                              onEnter: (_) =>
                                  setState(() => editIconIsHovered = true),
                              onExit: (_) =>
                                  setState(() => editIconIsHovered = false),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                                transform: Matrix4.identity()
                                  ..translate(0, editIconIsHovered ? -4 : 0),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.black.withValues(
                                        alpha: 0.05,
                                      ),
                                      blurRadius: editIconIsHovered
                                          ? 16.r
                                          : 8.r,
                                      spreadRadius: editIconIsHovered ? 4.r : 0,
                                      offset: Offset(
                                        0,
                                        editIconIsHovered ? 8.h : 4.h,
                                      ),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    size: 18.r,
                                    color: editIconIsHovered
                                        ? AppColors.blue
                                        : AppColors.iconDefaultGray,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return BlocProvider.value(
                                          value: context.read<CategoriesBloc>(),
                                          child: CategoryPropertiesWidget(
                                            isUpdateCategory: true,
                                            isAddCategory: false,
                                            id: widget.category.id,
                                            title: widget.category.name,
                                            imageUrl: widget.category.image,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            MouseRegion(
                              onEnter: (_) =>
                                  setState(() => deleteIconIsHovered = true),
                              onExit: (_) =>
                                  setState(() => deleteIconIsHovered = false),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                                transform: Matrix4.identity()
                                  ..translate(0, deleteIconIsHovered ? -4 : 0),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.black.withValues(
                                        alpha: 0.05,
                                      ),
                                      blurRadius: deleteIconIsHovered
                                          ? 16.r
                                          : 8.r,
                                      spreadRadius: deleteIconIsHovered
                                          ? 4.r
                                          : 0,
                                      offset: Offset(
                                        0,
                                        deleteIconIsHovered ? 8.h : 4.h,
                                      ),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: Icon(
                                    Icons.delete_outline,
                                    size: 18.r,
                                    color: deleteIconIsHovered
                                        ? AppColors.red
                                        : AppColors.iconDefaultGray,
                                  ),
                                  onPressed: () {
                                    AppDialogs.showCustomDialog(
                                      context: context,
                                      title: AppStrings.deleteCategoryTitle,
                                      content:
                                          AppStrings.deleteCategoryConfirmation,
                                      cancelText: AppStrings.cancel,
                                      confirmText: AppStrings.delete,
                                      onConfirm: () {
                                        context.read<CategoriesBloc>().add(
                                          DeleteCategoryEvent(
                                            widget.category.id,
                                          ),
                                        );
                                        // Navigator.pop(context);
                                      },
                                      titleIcon: Icons.delete_forever_outlined,
                                      confirmButtonColor: AppColors.red,
                                      iconColor: AppColors.white,
                                      iconBackgroundColor: AppColors.red,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class CustomAlertDialogWidget extends StatelessWidget {
//   final String title;
//   final String content;
//   Function on  ;
//   final BuildContext dialogContext;
//   const CustomAlertDialogWidget({
//     super.key,
//     required this.widget,
//     required this.dialogContext,
//     required this.title,
//     required this.content,
//   });

//   final CategoryCard widget;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: AppColors.white, // أو خليها الخلفية الكحلي حسب شاشتك
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
//       titlePadding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
//       contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//       actionsPadding: EdgeInsets.only(bottom: 20.h, right: 24.w, left: 24.w),
//       title: Row(
//         children: [
//           Container(
//             padding: EdgeInsets.all(8.r),
//             decoration: BoxDecoration(
//               color: AppColors.red.withValues(alpha: 0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.delete_forever_outlined,
//               color: AppColors.red,
//               size: 24.r,
//             ),
//           ),
//           SizedBox(width: 12.w),
//           Text(
//             'Delete Category',
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.bold,
//               color: AppColors.black,
//             ),
//           ),
//         ],
//       ),
//       content: Text(
//         'Are you sure you want to delete "${widget.category.name}"? This action cannot be undone.',
//         style: TextStyle(fontSize: 12.sp, color: Colors.grey[600], height: 1.4),
//       ),
//       actions: [
//         // زرار الإلغاء (Cancel)
//         OutlinedButton(
//           onPressed: () => Navigator.pop(dialogContext),
//           style: OutlinedButton.styleFrom(
//             side: BorderSide(color: Colors.grey[300]!),
//             padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.r),
//             ),
//           ),
//           child: Text(
//             'Cancel',
//             style: TextStyle(
//               color: Colors.grey[700],
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         SizedBox(width: 8.w),
//         // زرار التأكيد والحذف (Delete)
//         ElevatedButton(
//           onPressed: () {
//             context.read<CategoriesBloc>().add(
//               DeleteCategoryEvent(widget.category.id),
//             );
//             Navigator.pop(dialogContext);
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColors.red,
//             elevation: 0,
//             padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.r),
//             ),
//           ),
//           child: Text(
//             'Delete',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 14.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.textDarkSlate,
      width: double.infinity,
      child: Icon(Icons.image, color: AppColors.grey, size: 40.r),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
