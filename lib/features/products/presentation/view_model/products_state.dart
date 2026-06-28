import 'package:ecommerce_admin_app/features/products/domain/entites/products_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetProductsSuccess extends ProductsState {
  final List<ProductsEntity> products;

  const GetProductsSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class AddProductSuccess extends ProductsState {
  final ProductsEntity product;

  const AddProductSuccess(this.product);

  @override
  List<Object?> get props => [product];
}

class UpdateProductSuccess extends ProductsState {
  final ProductsEntity product;

  const UpdateProductSuccess(this.product);

  @override
  List<Object?> get props => [product];
}

class DeleteProductSuccess extends ProductsState {
  final bool isDeleted;

  const DeleteProductSuccess(this.isDeleted);

  @override
  List<Object?> get props => [isDeleted];
}

class SearchProductsSuccess extends ProductsState {
  final List<ProductsEntity> products;

  const SearchProductsSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class SearchProductsEmpty extends ProductsState {
  final String message;

  const SearchProductsEmpty(this.message);

  @override
  List<Object?> get props => [message];
}
