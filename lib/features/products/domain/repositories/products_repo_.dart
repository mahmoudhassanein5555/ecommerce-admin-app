import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/products/domain/entites/products_entity.dart';

abstract class ProductsRepo {
  Future<Either<Failure, List<ProductsEntity>>> getProducts({String? title});
  Future<Either<Failure, ProductsEntity>> updateProducts(
    int id,
    Map<String, dynamic> data,
  );
  Future<Either<Failure, ProductsEntity>> addProducts(
    Map<String, dynamic> data,
  );
  Future<Either<Failure, bool>> deleteProducts(int id);
  Future<Either<Failure, String>> uploadImage(
    Uint8List imageBytes,
    String fileName,
  );
}
