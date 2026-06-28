import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/products/domain/entites/products_entity.dart';
import 'package:ecommerce_admin_app/features/products/domain/repositories/products_repo_.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProductUseCase {
  final ProductsRepo repo;
  UpdateProductUseCase(this.repo);
  Future<Either<Failure, ProductsEntity>> invoke(
    int id,
    Map<String, dynamic> data,
  ) {
    return repo.updateProducts(id, data);
  }
}
