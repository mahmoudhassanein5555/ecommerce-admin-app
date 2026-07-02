import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/categories/domain/repositories/categories_repo_.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteCategoryUseCase {
  final CategoriesRepo repo;

  DeleteCategoryUseCase(this.repo);

  Future<Either<Failure, bool>> invoke(int id) => repo.deleteCategory(id);
}
