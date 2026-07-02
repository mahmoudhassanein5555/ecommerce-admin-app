import 'package:ecommerce_admin_app/features/categories/domain/entites/category_entity.dart';
import 'package:ecommerce_admin_app/features/products/domain/entites/products_entity.dart'
    show ProductsEntity;
import 'package:equatable/equatable.dart';

abstract class CategoriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class GetCategoriesSuccess extends CategoriesState {
  final List<CategoryEntity> categories;

  GetCategoriesSuccess(this.categories);
  @override
  List<Object?> get props => [categories];
}

class AddCategorySuccess extends CategoriesState {
  final CategoryEntity category;

  AddCategorySuccess(this.category);
  @override
  List<Object?> get props => [category];
}

class UpdateCategorySuccess extends CategoriesState {
  final CategoryEntity category;

  UpdateCategorySuccess(this.category);
  @override
  List<Object?> get props => [category];
}

class DeleteCategorySuccess extends CategoriesState {
  final bool isDeleted;

  DeleteCategorySuccess(this.isDeleted);
  @override
  List<Object?> get props => [isDeleted];
}

class GetProductsByCategorySuccess extends CategoriesState {
  final List<ProductsEntity> products;

  GetProductsByCategorySuccess(this.products);
  @override
  List<Object?> get props => [products];
}

class CategoriesError extends CategoriesState {
  final String message;

  CategoriesError(this.message);
  @override
  List<Object?> get props => [message];
}
