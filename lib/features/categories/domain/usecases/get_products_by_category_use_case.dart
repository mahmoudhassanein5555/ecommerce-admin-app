import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/categories/domain/repositories/categories_repo_.dart';
import 'package:ecommerce_admin_app/features/products/domain/entites/products_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsByCategoryUseCase {
  final CategoriesRepo repo;

  GetProductsByCategoryUseCase(this.repo);

  Future<Either<Failure, List<ProductsEntity>>> invoke(int id) =>
      repo.getProductsByCategory(id);
}
