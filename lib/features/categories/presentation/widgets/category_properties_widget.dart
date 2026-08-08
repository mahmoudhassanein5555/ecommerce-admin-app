import 'dart:typed_data';

import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/core/common/widgets/custom_text_form_field.dart';
import 'package:ecommerce_admin_app/features/categories/presentation/view_model/categories_bloc.dart';
import 'package:ecommerce_admin_app/features/categories/presentation/view_model/categories_event.dart';
import 'package:ecommerce_admin_app/features/categories/presentation/widgets/product_image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPropertiesWidget extends StatefulWidget {
  final String? title;
  final int? id;
  final String? imageUrl;
  final bool isUpdateCategory;
  final bool isAddCategory;

  const CategoryPropertiesWidget({
    super.key,
    this.title,
    this.id,
    this.imageUrl,
    this.isUpdateCategory = false,
    this.isAddCategory = false,
  });

  @override
  State<CategoryPropertiesWidget> createState() =>
      _CategoryPropertiesWidgetState();
}

class _CategoryPropertiesWidgetState extends State<CategoryPropertiesWidget> {
  Uint8List? selectedImageBytes;
  String? fileName;
  late final TextEditingController categoryNameController;

  @override
  void initState() {
    super.initState();
    categoryNameController = TextEditingController();

    if (widget.isUpdateCategory) {
      categoryNameController.text = widget.title ?? '';
    }
  }

  @override
  void dispose() {
    categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder:
          (BuildContext context, void Function(void Function()) setState) =>
              Dialog(
                backgroundColor: AppColors.white,
                surfaceTintColor: AppColors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: SizedBox(
                  width: 600.w,
                  child: Padding(
                    padding: EdgeInsets.all(24.0.r),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.isAddCategory
                                  ? Text(
                                      AppStrings.addCategoryTitle,
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.sp,
                                      ),
                                    )
                                  : Text(
                                      AppStrings.updateCategoryTitle,
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.sp,
                                      ),
                                    ),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.close,
                                  color: AppColors.grey,
                                  size: 22.r,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            AppStrings.categoryNameLabel,
                            style: TextStyle(
                              color: AppColors.textDarkSlate,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CustomTextFormField(
                            controller: categoryNameController,
                            hintText: AppStrings.categoryNameHint,
                            hintTextColor: AppColors.grey400,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            AppStrings.categoryImageLabel,
                            style: TextStyle(
                              color: AppColors.textDarkSlate,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CategoryImagePickerWidget(
                            label: AppStrings.imagePickerLabel,
                            subLabel: AppStrings.imagePickerSubLabel,
                            imageUrl: widget.imageUrl,
                            imageBytes: selectedImageBytes,
                            isUpdateProduct: widget.isUpdateCategory,
                            onImageSelected: (bytes, name) {
                              setState(() {
                                selectedImageBytes = bytes;
                                fileName = name;
                              });
                            },
                            onImageRemoved: () {
                              setState(() {
                                selectedImageBytes = null;
                                fileName = null;
                              });
                            },
                            leftPadding: 130,
                          ),
                          SizedBox(height: 32.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: AppColors.grey300),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 16.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                child: Text(
                                  AppStrings.cancel,
                                  style: TextStyle(
                                    color: AppColors.textDarkSlate,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              ElevatedButton(
                                onPressed: () {
                                  final data = <String, dynamic>{
                                    'name': categoryNameController.text.trim(),
                                    'image': widget.imageUrl ?? '',
                                  };

                                  if (widget.isUpdateCategory) {
                                    context.read<CategoriesBloc>().add(
                                      UpdateCategoryEvent(
                                        widget.id!,
                                        data,
                                        selectedImageBytes: selectedImageBytes,
                                        fileName: fileName,
                                      ),
                                    );
                                  } else if (widget.isAddCategory) {
                                    context.read<CategoriesBloc>().add(
                                      AddCategoryEvent(
                                        data,
                                        selectedImageBytes: selectedImageBytes,
                                        fileName: fileName,
                                      ),
                                    );
                                  }
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.buttonColor,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 16.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  AppStrings.saveCategory,
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
    );
  }
}
