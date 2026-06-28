import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/products/domain/entites/products_entity.dart';
import 'package:ecommerce_admin_app/features/products/domain/repositories/products_repo_.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductUseCase {
  final ProductsRepo repo;
  AddProductUseCase(this.repo);
  Future<Either<Failure, ProductsEntity>> invoke(Map<String, dynamic> data) =>
      repo.addProducts(data);
}
