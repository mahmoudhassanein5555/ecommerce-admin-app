import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/categories/domain/entites/category_entity.dart';
import 'package:ecommerce_admin_app/features/products/domain/entites/products_entity.dart'
    show ProductsEntity;

abstract class CategoriesRepo {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, CategoryEntity>> addCategory(
    Map<String, dynamic> data,
  );
  Future<Either<Failure, CategoryEntity>> updateCategory(
    int id,
    Map<String, dynamic> data,
  );
  Future<Either<Failure, bool>> deleteCategory(int id);
  Future<Either<Failure, List<ProductsEntity>>> getProductsByCategory(int id);
}
