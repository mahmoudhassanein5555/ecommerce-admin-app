import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/core/utils/app_toasts.dart';
import 'package:ecommerce_admin_app/features/categories/presentation/view_model/categories_bloc.dart';
import 'package:ecommerce_admin_app/features/categories/presentation/view_model/categories_event.dart';
import 'package:ecommerce_admin_app/features/categories/presentation/view_model/categories_state.dart';
import 'package:ecommerce_admin_app/features/categories/presentation/widgets/category_card.dart';
import 'package:ecommerce_admin_app/features/categories/presentation/widgets/category_header_widget.dart';
import 'package:ecommerce_admin_app/features/products/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().add(GetCategoriesEvent());
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = AppColors.backgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryHeaderWidget(),
              SizedBox(height: 24.h),

              SizedBox(height: 24.h),
              Expanded(
                child: BlocConsumer<CategoriesBloc, CategoriesState>(
                  buildWhen: (previous, current) {
                    return current is GetCategoriesSuccess ||
                        current is CategoriesLoading ||
                        current is CategoriesError ||
                        current is GetProductsByCategorySuccess ||
                        current is AddCategorySuccess ||
                        current is UpdateCategorySuccess;
                  },
                  builder: (context, state) {
                    if (state is GetCategoriesSuccess) {
                      final categories = state.categories;
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                          childAspectRatio: 0.78,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return CategoryCard(category: category);
                        },
                      );
                    } else if (state is GetProductsByCategorySuccess) {
                      if (state.products.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                size: 80.r,
                                color: AppColors.grey400,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                AppStrings.noProductsFoundInCategory,
                                style: TextStyle(
                                  color: AppColors.grey600,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 24.h),
                              TextButton.icon(
                                onPressed: () {
                                  context.read<CategoriesBloc>().add(
                                    GetCategoriesEvent(),
                                  );
                                },
                                icon: const Icon(Icons.arrow_back),
                                label: const Text(AppStrings.backToCategories),
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.categoryAccent,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              context.read<CategoriesBloc>().add(
                                GetCategoriesEvent(),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 16.sp,
                              color: AppColors.textBrown,
                            ),
                            label: Text(
                              AppStrings.backToCategories,
                              style: TextStyle(
                                color: AppColors.textBrown,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5,
                                    crossAxisSpacing: 16.w,
                                    mainAxisSpacing: 16.h,
                                    childAspectRatio: 0.78,
                                  ),
                              itemCount: state.products.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ProductCard(
                                  title: state.products[index].title,
                                  price: state.products[index].price.toDouble(),
                                  categoryName:
                                      state.products[index].category.name,
                                  stockColor: AppColors.categoryAccent,
                                  visibilityColor: AppColors.visibilityColor,
                                  visibilityTextColor: AppColors.textBrown,
                                  imageUrl1:
                                      state.products[index].images.isNotEmpty
                                      ? state.products[index].images[0]
                                      : null,
                                  imageUrl2:
                                      state.products[index].images.length > 1
                                      ? state.products[index].images[1]
                                      : null,
                                  imageUrl3:
                                      state.products[index].images.length > 2
                                      ? state.products[index].images[2]
                                      : null,
                                  id: state.products[index].id,
                                  description:
                                      state.products[index].description,
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (state is CategoriesLoading) {
                      return Center(
                        child: SizedBox(
                          width: 300.w,
                          height: 300.h,
                          child: Lottie.asset('assets/animations/loading.json'),
                        ),
                      );
                    } else if (state is CategoriesError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: TextStyle(
                            color: AppColors.red,
                            fontSize: 16.sp,
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 250.w,
                            height: 250.h,
                            child: Lottie.asset(
                              'assets/animations/error 404.json',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            AppStrings.categoryUnexpectedStateMessage,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.categoryAccent,
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 12.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            icon: const Icon(
                              Icons.refresh,
                              color: AppColors.white,
                            ),
                            label: Text(
                              AppStrings.reloadCategories,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              context.read<CategoriesBloc>().add(
                                GetCategoriesEvent(),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  listener: (BuildContext context, CategoriesState state) {
                    if (state is DeleteCategorySuccess) {
                      AppToast.showToast(
                        context: context,
                        title: "Category deleted",
                        description: "The category was deleted successfully",
                        type: ToastificationType.success,
                      );
                    } else if (state is AddCategorySuccess) {
                      AppToast.showToast(
                        context: context,
                        title: "Category added",
                        description: "The category was added successfully",
                        type: ToastificationType.success,
                      );
                    } else if (state is UpdateCategorySuccess) {
                      AppToast.showToast(
                        context: context,
                        title: "Category updated ",
                        description: "The category was updated successfully",
                        type: ToastificationType.success,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
