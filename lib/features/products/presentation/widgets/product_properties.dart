import 'dart:typed_data';

import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:ecommerce_admin_app/features/products/presentation/view_model/products_bloc.dart';
import 'package:ecommerce_admin_app/features/products/presentation/view_model/products_event.dart';
import 'package:ecommerce_admin_app/features/products/presentation/widgets/product_image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductPropertiesWidget extends StatefulWidget {
  final String? title;
  final String? description;
  final double? price;
  final int? id;
  final String? imageUrl1;
  final String? imageUrl2;
  final String? imageUrl3;
  final bool isUpdateProduct;
  final bool isAddProduct;
  const ProductPropertiesWidget({
    super.key,
    this.title,
    this.description,
    this.price,
    this.id,
    this.imageUrl1,
    this.imageUrl2,
    this.imageUrl3,
    this.isUpdateProduct = false,
    this.isAddProduct = false,
  });

  @override
  State<ProductPropertiesWidget> createState() =>
      _ProductPropertiesWidgetState();
}

class _ProductPropertiesWidgetState extends State<ProductPropertiesWidget> {
  Uint8List? selectedImageBytes1;
  String? fileName1;
  Uint8List? selectedImageBytes2;
  String? fileName2;
  Uint8List? selectedImageBytes3;
  String? fileName3;
  String? selectedCategory;
  late final TextEditingController productPriceController;
  late final TextEditingController productTitleController;
  late final TextEditingController productDescriptionController;

  @override
  void initState() {
    super.initState();
    productDescriptionController = TextEditingController();
    productTitleController = TextEditingController();
    productPriceController = TextEditingController();

    if (widget.isUpdateProduct) {
      productDescriptionController.text = widget.description!;
      productTitleController.text = widget.title!;
      productPriceController.text = widget.price.toString();
    }
  }

  @override
  void dispose() {
    productPriceController.dispose();
    productDescriptionController.dispose();
    productTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder:
          (
            BuildContext context,
            void Function(void Function()) setState,
          ) => Dialog(
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
                          widget.isAddProduct
                              ? Text(
                                  AppStrings.updateProduct,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.sp,
                                  ),
                                )
                              : Text(
                                  AppStrings.addNewProductTitle,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.sp,
                                  ),
                                ),

                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
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
                        AppStrings.productTitleLabel,
                        style: TextStyle(
                          color: AppColors.textDarkSlate,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextFormField(
                        controller: productTitleController,
                        hintText: AppStrings.productTitleHint,
                        hintTextColor: Colors.grey.shade400,
                      ),
                      SizedBox(height: 20.h),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Price Section
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.priceUsdLabel,
                                  style: TextStyle(
                                    color: AppColors.textDarkSlate,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                CustomTextFormField(
                                  controller: productPriceController,
                                  hintText: AppStrings.priceHint,
                                  hintTextColor: Colors.grey.shade400,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 24.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.categoryLabel,
                                  style: TextStyle(
                                    color: AppColors.textDarkSlate,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                DropdownButtonFormField<String>(
                                  initialValue: selectedCategory,
                                  hint: Text(
                                    AppStrings.selectCategoryHint,
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.grey,
                                    size: 20.r,
                                  ),
                                  dropdownColor: AppColors.white,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 12.h,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                        color: AppColors.buttonColor,
                                      ),
                                    ),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'Electronics',
                                      child: Text('Electronics'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Furniture',
                                      child: Text('Furniture'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Clothes',
                                      child: Text('Clothes'),
                                    ),
                                  ],
                                  onChanged: (newValue) {
                                    selectedCategory = newValue;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      Text(
                        AppStrings.descriptionLabel,
                        style: TextStyle(
                          color: AppColors.textDarkSlate,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        controller: productDescriptionController,
                        maxLines: 4,
                        minLines: 3,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 12.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: AppStrings.descriptionHint,
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 12.sp,
                          ),
                          contentPadding: EdgeInsets.all(16.r),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                              color: AppColors.buttonColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      Text(
                        AppStrings.productImagesLabel,
                        style: TextStyle(
                          color: AppColors.textDarkSlate,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      ProductImagePickerWidget(
                        label: AppStrings.imagePickerLabel,
                        subLabel: AppStrings.imagePickerSubLabel,
                        imageUrl: widget.imageUrl1,
                        imageBytes: selectedImageBytes1,
                        isUpdateProduct: true,
                        onImageSelected: (bytes, name) {
                          setState(() {
                            selectedImageBytes1 = bytes;
                            fileName1 = name;
                          });
                        },
                        onImageRemoved: () {
                          setState(() {
                            selectedImageBytes1 = null;
                            fileName1 = null;
                          });
                        },
                        leftPadding: 130,
                      ),
                      SizedBox(height: 12.h),

                      Row(
                        children: [
                          Expanded(
                            child: ProductImagePickerWidget(
                              label: AppStrings.imagePickerLabel,
                              subLabel: AppStrings.imagePickerSubLabel,
                              imageUrl: widget.imageUrl2,
                              imageBytes: selectedImageBytes2,
                              isUpdateProduct: true,
                              onImageSelected: (bytes, name) {
                                setState(() {
                                  selectedImageBytes2 = bytes;
                                  fileName2 = name;
                                });
                              },
                              onImageRemoved: () {
                                setState(() {
                                  selectedImageBytes2 = null;
                                  fileName2 = null;
                                });
                              },
                              leftPadding: 60,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: ProductImagePickerWidget(
                              label: AppStrings.imagePickerLabel,
                              subLabel: AppStrings.imagePickerSubLabel,
                              imageUrl: widget.imageUrl3,
                              imageBytes: selectedImageBytes3,
                              isUpdateProduct: true,
                              onImageSelected: (bytes, name) {
                                setState(() {
                                  selectedImageBytes3 = bytes;
                                  fileName3 = name;
                                });
                              },
                              onImageRemoved: () {
                                setState(() {
                                  selectedImageBytes3 = null;
                                  fileName3 = null;
                                });
                              },
                              leftPadding: 60,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade300),
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
                              if (widget.isUpdateProduct) {
                                context.read<ProductsBloc>().add(
                                  UpdateProductEvent(
                                    widget.id!,
                                    {
                                      "title": productTitleController.text,
                                      "price": productPriceController.text,
                                      "description":
                                          productDescriptionController.text,
                                      "images": [
                                        widget.imageUrl1,
                                        widget.imageUrl2,
                                        widget.imageUrl3,
                                      ],
                                    },
                                    selectedImageBytes1: selectedImageBytes1,
                                    fileName1: fileName1,
                                    selectedImageBytes2: selectedImageBytes2,
                                    fileName2: fileName2,
                                    selectedImageBytes3: selectedImageBytes3,
                                    fileName3: fileName3,
                                  ),
                                );
                              } else if (widget.isAddProduct) {
                                context.read<ProductsBloc>().add(
                                  AddProductEvent(
                                    {
                                      "title": productTitleController.text,
                                      "price": productPriceController.text,
                                      "description":
                                          productDescriptionController.text,
                                      "categoryId": 2,
                                      "images": [
                                        widget.imageUrl1,
                                        widget.imageUrl2,
                                        widget.imageUrl3,
                                      ],
                                    },
                                    selectedImageBytes1: selectedImageBytes1,
                                    fileName1: fileName1,
                                    selectedImageBytes2: selectedImageBytes2,
                                    fileName2: fileName2,
                                    selectedImageBytes3: selectedImageBytes3,
                                    fileName3: fileName3,
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
                              AppStrings.saveProduct,
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
