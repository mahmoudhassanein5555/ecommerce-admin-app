import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/features/products/presentation/view_model/products_bloc.dart';
import 'package:ecommerce_admin_app/features/products/presentation/view_model/products_event.dart';
import 'package:ecommerce_admin_app/features/products/presentation/widgets/product_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 

class ProductCard extends StatefulWidget {
  final String title;
  final String description;
  final double price;
  final int id;
  final String? imageUrl1;
  final String? imageUrl2;
  final String? imageUrl3;
  final String categoryName;
  final Color stockColor;
  final Color visibilityColor;
  final Color visibilityTextColor;
  final bool isPlaceholder;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.categoryName,
    required this.stockColor,
    required this.visibilityColor,
    required this.visibilityTextColor,
    this.imageUrl1,
    this.isPlaceholder = false,
    required this.id,
    required this.description,
    this.imageUrl2,
    this.imageUrl3,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool cardIsHovered = false;
  bool updateIconisHovered = false;
  bool deleteIconisHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => cardIsHovered = true),

      onExit: (_) => setState(() => cardIsHovered = false),
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
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r), 
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.04),
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child:
                    widget.isPlaceholder ||
                        widget.imageUrl1 == null ||
                        widget.imageUrl1!.isEmpty
                    ? const _ImagePlaceholder()
                    : CachedNetworkImage(
                        imageUrl: widget.imageUrl1!,
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
                              Color(0xFFB45309),
                            ),
                            backgroundColor: const Color(0xFFE2E8F0),
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
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: AppColors.textDarkSlate,
                          fontSize: 12.sp, 
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w, 
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: widget.stockColor,
                                borderRadius: BorderRadius.circular(
                                  20.r,
                                ), 
                              ),
                              child: Text(
                                widget.categoryName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 9.sp, 
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w), 

                          Flexible(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: widget.visibilityColor,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                '\$${widget.price}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: widget.visibilityTextColor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const Spacer(),
                          MouseRegion(
                            onEnter: (_) =>
                                setState(() => updateIconisHovered = true),
                            onExit: (_) =>
                                setState(() => updateIconisHovered = false),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOut,
                              transform: Matrix4.identity()
                                ..translate(0, updateIconisHovered ? -4 : 0),

                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withValues(
                                      alpha: 0.05,
                                    ),
                                    blurRadius: updateIconisHovered
                                        ? 16.r
                                        : 8.r,
                                    spreadRadius: updateIconisHovered ? 4.r : 0,
                                    offset: Offset(
                                      0,
                                      updateIconisHovered ? 8.h : 4.h,
                                    ),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.edit_outlined,
                                  size: 20.r, 
                                  color: updateIconisHovered
                                      ? AppColors.blue
                                      : AppColors.iconDefaultGray,
                                ),
                                onPressed: () {
                                  final productsBloc = context
                                      .read<ProductsBloc>();
                                  showDialog(
                                    context: context,
                                    builder: (dialogContext) =>
                                        BlocProvider.value(
                                          value: productsBloc,
                                          child: ProductPropertiesWidget(
                                            isUpdateProduct: true,
                                            title: widget.title,
                                            description: widget.description,
                                            price: widget.price,
                                            id: widget.id,
                                            imageUrl1: widget.imageUrl1,
                                            imageUrl2: widget.imageUrl2,
                                            imageUrl3: widget.imageUrl3,
                                          ),
                                        ),
                                  );
                                },
                              ),
                            ),
                          ),

                          SizedBox(width: 8.w),
                          MouseRegion(
                            onEnter: (_) =>
                                setState(() => deleteIconisHovered = true),
                            onExit: (_) =>
                                setState(() => deleteIconisHovered = false),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOut,
                              transform: Matrix4.identity()
                                ..translate(0, deleteIconisHovered ? -4 : 0),

                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withValues(
                                      alpha: 0.05,
                                    ),
                                    blurRadius: deleteIconisHovered
                                        ? 16.r
                                        : 8.r,
                                    spreadRadius: deleteIconisHovered ? 4.r : 0,
                                    offset: Offset(
                                      0,
                                      deleteIconisHovered ? 8.h : 4.h,
                                    ),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: Icon(
                                  Icons.delete_outline,
                                  size: 20.r, 
                                  color: deleteIconisHovered
                                      ? AppColors.red
                                      : AppColors.iconDefaultGray,
                                ),
                                onPressed: () {
                                  BlocProvider.of<ProductsBloc>(
                                    context,
                                  ).add(DeleteProductEvent(widget.id));
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
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.textDarkSlate,
      width: double.infinity,
      child: Icon(
        Icons.image,
        color: AppColors.grey,
        size: 40.r,
      ), 
    );
  }
}
