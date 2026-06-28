import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/products/domain/repositories/products_repo_.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteProductUseCase {
  final ProductsRepo repo;
  DeleteProductUseCase(this.repo);
  Future<Either<Failure, bool>> invoke(int id) => repo.deleteProducts(id);
}
