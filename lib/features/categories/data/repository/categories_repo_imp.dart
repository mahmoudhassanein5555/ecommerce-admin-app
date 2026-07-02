import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/errors/error_handler.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/core/network/connection_checker.dart';
import 'package:ecommerce_admin_app/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:ecommerce_admin_app/features/categories/domain/entites/category_entity.dart';
import 'package:ecommerce_admin_app/features/categories/domain/repositories/categories_repo_.dart';
import 'package:ecommerce_admin_app/features/products/domain/entites/products_entity.dart'
    show ProductsEntity;
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoriesRepo)
class CategoriesRepoImp implements CategoriesRepo {
  final CategoriesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CategoriesRepoImp(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    if (!await networkInfo.isConnected) {
      return left(Failure('No internet connection'));
    }
    try {
      final response = await remoteDataSource.getCategories();
      return right(response.cast<CategoryEntity>());
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> addCategory(
    Map<String, dynamic> data,
  ) async {
    if (!await networkInfo.isConnected) {
      return left(Failure('No internet connection'));
    }
    try {
      final response = await remoteDataSource.addCategory(data);
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> updateCategory(
    int id,
    Map<String, dynamic> data,
  ) async {
    if (!await networkInfo.isConnected) {
      return left(Failure('No internet connection'));
    }
    try {
      final response = await remoteDataSource.updateCategory(id, data);
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCategory(int id) async {
    if (!await networkInfo.isConnected) {
      return left(Failure('No internet connection'));
    }
    try {
      final response = await remoteDataSource.deleteCategory(id);
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<ProductsEntity>>> getProductsByCategory(
    int id,
  ) async {
    if (!await networkInfo.isConnected) {
      return left(Failure('No internet connection'));
    }
    try {
      final response = await remoteDataSource.getProductsByCategory(id);
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
