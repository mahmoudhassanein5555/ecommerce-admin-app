import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/products/domain/entites/products_entity.dart';
import 'package:ecommerce_admin_app/features/products/domain/repositories/products_repo_.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsUseCase {
  final ProductsRepo repo;
  GetProductsUseCase(this.repo);
  Future<Either<Failure, List<ProductsEntity>>> invoke({String? title}) =>
      repo.getProducts(title: title);
}
