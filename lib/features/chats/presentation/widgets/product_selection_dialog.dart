import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/core/di/servicelocator.dart';
import 'package:ecommerce_admin_app/features/products/domain/entites/products_entity.dart';
import 'package:ecommerce_admin_app/features/products/presentation/view_model/products_bloc.dart';
import 'package:ecommerce_admin_app/features/products/presentation/view_model/products_event.dart';
import 'package:ecommerce_admin_app/features/products/presentation/view_model/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ProductSelectionDialog extends StatefulWidget {
  const ProductSelectionDialog({super.key});

  static Future<ProductsEntity?> show(BuildContext context) {
    return showDialog<ProductsEntity>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return BlocProvider(
          create: (context) => getIt<ProductsBloc>()..add(GetProductsEvent()),
          child: const ProductSelectionDialog(),
        );
      },
    );
  }

  @override
  State<ProductSelectionDialog> createState() => _ProductSelectionDialogState();
}

class _ProductSelectionDialogState extends State<ProductSelectionDialog> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      backgroundColor: AppColors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Container(
        width: 650.w,
        height: 480.h,
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: AppColors.chatGoldAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: AppColors.chatGoldAccent,
                    size: 20.r,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.selectProductToAttachTitle,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDarkSlate,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        AppStrings.selectProductToAttachSubtitle,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.grey600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: AppColors.grey, size: 18.r),
                  visualDensity: VisualDensity.compact,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            const Divider(height: 1, color: AppColors.chatBorder),
            SizedBox(height: 12.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.chatBackground,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: AppColors.grey300),
              ),
              child: TextField(
                controller: _searchController,
                style: TextStyle(fontSize: 12.5.sp),
                onChanged: (query) {
                  context.read<ProductsBloc>().add(SearchProductsEvent(query));
                },
                decoration: InputDecoration(
                  hintText: AppStrings.searchProductsHint,
                  hintStyle: TextStyle(
                    color: AppColors.grey500,
                    fontSize: 11.5.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.grey,
                    size: 18.r,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            size: 16.r,
                            color: AppColors.grey,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            context.read<ProductsBloc>().add(
                              SearchProductsEvent(''),
                            );
                            setState(() {});
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoading) {
                    return Center(
                      child: SizedBox(
                        width: 120.w,
                        height: 120.h,
                        child: Lottie.asset('assets/animations/loading.json'),
                      ),
                    );
                  }

                  if (state is ProductsError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.message,
                            style: TextStyle(
                              color: AppColors.red,
                              fontSize: 13.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          ElevatedButton(
                            onPressed: () {
                              context.read<ProductsBloc>().add(
                                GetProductsEvent(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.chatGoldAccent,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                            ),
                            child: Text(
                              AppStrings.retry,
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is SearchProductsEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 38.r,
                            color: AppColors.grey400,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            AppStrings.noProductsFound,
                            style: TextStyle(
                              color: AppColors.grey600,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is GetProductsSuccess) {
                    final products = state.products;
                    if (products.isEmpty) {
                      return Center(
                        child: Text(
                          AppStrings.noProductsFound,
                          style: TextStyle(
                            color: AppColors.grey600,
                            fontSize: 13.sp,
                          ),
                        ),
                      );
                    }

                    return GridView.builder(
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 1.25,
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        final imageUrl = product.images.isNotEmpty
                            ? product.images.first
                            : '';

                        return _ProductDialogCard(
                          product: product,
                          imageUrl: imageUrl,
                          onSelect: () {
                            Navigator.of(context).pop(product);
                          },
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductDialogCard extends StatefulWidget {
  final ProductsEntity product;
  final String imageUrl;
  final VoidCallback onSelect;

  const _ProductDialogCard({
    required this.product,
    required this.imageUrl,
    required this.onSelect,
  });

  @override
  State<_ProductDialogCard> createState() => _ProductDialogCardState();
}

class _ProductDialogCardState extends State<_ProductDialogCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: widget.onSelect,
        borderRadius: BorderRadius.circular(10.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isHovered
                  ? AppColors.chatGoldAccent
                  : AppColors.grey200,
              width: isHovered ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovered
                    ? AppColors.chatGoldAccent.withValues(alpha: 0.12)
                    : AppColors.black.withValues(alpha: 0.03),
                blurRadius: isHovered ? 8.r : 3.r,
                offset: Offset(0, isHovered ? 3.h : 1.h),
              ),
            ],
          ),
          padding: EdgeInsets.all(8.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: SizedBox(
                  width: 58.w,
                  height: 58.h,
                  child: widget.imageUrl.isNotEmpty &&
                          widget.imageUrl.startsWith('http')
                      ? CachedNetworkImage(
                          imageUrl: widget.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: AppColors.grey100,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: AppColors.grey100,
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 22.r,
                              color: AppColors.grey,
                            ),
                          ),
                        )
                      : Container(
                          color: AppColors.grey100,
                          child: Icon(
                            Icons.image_outlined,
                            size: 22.r,
                            color: AppColors.grey,
                          ),
                        ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.product.category.name.isNotEmpty) ...[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.chatTagBg,
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                        child: Text(
                          widget.product.category.name,
                          style: TextStyle(
                            fontSize: 8.5.sp,
                            color: AppColors.grey700,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 2.h),
                    ],
                    Text(
                      widget.product.title,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDarkSlate,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '\$${widget.product.price}',
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.chatGoldAccent,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 4.w),
              Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: isHovered
                      ? AppColors.chatGoldAccent
                      : AppColors.chatBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  size: 14.r,
                  color: isHovered ? AppColors.white : AppColors.grey600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
