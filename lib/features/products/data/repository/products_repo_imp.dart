import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/errors/error_handler.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/core/network/connection_checker.dart';
import 'package:ecommerce_admin_app/features/products/data/datasources/products_remote_data_source.dart';
import 'package:ecommerce_admin_app/features/products/domain/entites/products_entity.dart';
import 'package:ecommerce_admin_app/features/products/domain/repositories/products_repo_.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductsRepo)
class ProductsRepoImp extends ProductsRepo {
  final ProductsRemoteDataSource productsRemoteDataSource;
  final NetworkInfo networkInfo;
  ProductsRepoImp(this.productsRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, ProductsEntity>> addProducts(
    Map<String, dynamic> data,
  ) async {
    if (!await networkInfo.isConnected) {
      return left(Failure("No internet connection"));
    }
    try {
      var response = await productsRemoteDataSource.addNewProduct(data);
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProducts(int id) async {
    if (!await networkInfo.isConnected) {
      return left(Failure("No internet connection"));
    }
    try {
      var response = await productsRemoteDataSource.deleteProducts(id);
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<ProductsEntity>>> getProducts({
    String? title,
  }) async {
    if (!await networkInfo.isConnected) {
      return left(Failure("No internet connection"));
    }
    try {
      var response;
      if (title != null) {
        response = await productsRemoteDataSource.getProducts(title: title);
        return right(response);
      } else {
        response = await productsRemoteDataSource.getProducts();
        return right(response);
      }
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, ProductsEntity>> updateProducts(
    int id,
    Map<String, dynamic> data,
  ) async {
    if (!await networkInfo.isConnected) {
      return left(Failure("No internet connection"));
    }
    try {
      var response = await productsRemoteDataSource.updateProduct(id, data);
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(
    Uint8List imageBytes,
    String fileName,
  ) async {
    try {
      var response = await productsRemoteDataSource.uploadImage(
        imageBytes,
        fileName,
      );
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
