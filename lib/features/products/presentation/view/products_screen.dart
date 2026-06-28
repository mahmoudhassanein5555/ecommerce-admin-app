import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/core/utils/app_toasts.dart';
import 'package:ecommerce_admin_app/features/products/presentation/view_model/products_bloc.dart';
import 'package:ecommerce_admin_app/features/products/presentation/view_model/products_event.dart';
import 'package:ecommerce_admin_app/features/products/presentation/view_model/products_state.dart';
import 'package:ecommerce_admin_app/features/products/presentation/widgets/product_card.dart';
import 'package:ecommerce_admin_app/features/products/presentation/widgets/product_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsBloc>(context).add(GetProductsEvent());
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
    const searchBarColor = AppColors.searchBarColor;
    const buttonColor = AppColors.buttonColor;

    return Builder(
      builder: (BuildContext context) => Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.productsManagement,
                          style: TextStyle(
                            color: AppColors.textBrown,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          AppStrings.manageProductSubheadline,
                          style: TextStyle(
                            color: AppColors.textBrown,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        final productsBloc = BlocProvider.of<ProductsBloc>(
                          context,
                        );
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return BlocProvider.value(
                              value: productsBloc,
                              child: const ProductPropertiesWidget(
                                isAddProduct: true,
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.add, color: Colors.white, size: 18.r),
                      label: Text(
                        AppStrings.addNewProduct,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            context.read<ProductsBloc>().add(
                              SearchProductsEvent(value),
                            );
                          },
                          controller: searchController,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16.sp,
                          ),
                          decoration: InputDecoration(
                            hintText: AppStrings.searchProductsHint,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 13.sp,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 20.r,
                            ),
                            border: InputBorder.none,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 2.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 14.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.filter_list,
                        color: Colors.grey,
                        size: 18.r,
                      ),
                      label: Text(
                        AppStrings.filterButtonText,
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: searchBarColor,
                        side: BorderSide.none,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: BlocConsumer<ProductsBloc, ProductsState>(
                    buildWhen: (previous, current) {
                      return current is GetProductsSuccess ||
                          current is ProductsLoading ||
                          current is ProductsError ||
                          current is SearchProductsEmpty;
                    },
                    builder: (context, state) {
                      if (state is GetProductsSuccess) {
                        return GridView.builder(
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
                              categoryName: state.products[index].category.name,
                              stockColor: const Color(0xFFB45309),
                              visibilityColor: AppColors.visibilityColor,
                              visibilityTextColor: AppColors.textBrown,
                              imageUrl1: state.products[index].images.isNotEmpty
                                  ? state.products[index].images[0]
                                  : null,
                              imageUrl2: state.products[index].images.length > 1
                                  ? state.products[index].images[1]
                                  : null,
                              imageUrl3: state.products[index].images.length > 2
                                  ? state.products[index].images[2]
                                  : null,
                              id: state.products[index].id,
                              description: state.products[index].description,
                            );
                          },
                        );
                      } else if (state is ProductsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 4.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.loaderAmber,
                            ),
                            backgroundColor: AppColors.loaderBackground,
                            strokeCap: StrokeCap.round,
                          ),
                        );
                      } else if (state is SearchProductsEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 500.w,
                                height: 500.h,
                                child: Lottie.asset(
                                  'assets/animations/error 404.json',
                                ),
                              ),
                              Text(
                                AppStrings.noResultsFound,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'SwiftBuyBrand',
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                AppStrings.noResultsDescription,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.sp,
                                  fontFamily: 'SwiftBuyBody',
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (state is DeleteProductSuccess ||
                          state is AddProductSuccess ||
                          state is UpdateProductSuccess ||
                          state is ProductsInitial) {
                        return const SizedBox.shrink();
                      } else {
                        return Center(
                          child: Text(
                            '${AppStrings.somethingWentWrong} (${state.runtimeType})',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.sp,
                            ),
                          ),
                        );
                      }
                    },
                    listener: (BuildContext context, ProductsState state) {
                      if (state is DeleteProductSuccess) {
                        AppToast.showToast(
                          context: context,
                          title: AppStrings.productDeletedTitle,
                          description: AppStrings.productDeletedDesc,
                          type: ToastificationType.success,
                        );
                      } else if (state is AddProductSuccess) {
                        AppToast.showToast(
                          context: context,
                          title: AppStrings.addNewProduct,
                          description: AppStrings.productAddedDesc,
                          type: ToastificationType.success,
                        );
                      } else if (state is ProductsError) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          AppToast.showToast(
                            context: context,
                            title: AppStrings.errorFetchingProducts,
                            description: state.message,
                            type: ToastificationType.error,
                          );
                        });
                      } else if (state is UpdateProductSuccess) {
                        AppToast.showToast(
                          context: context,
                          title: AppStrings.productUpdatedTitle,
                          description: AppStrings.productUpdatedDesc,
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
      ),
    );
  }
}
