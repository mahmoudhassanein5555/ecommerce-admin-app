import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/categories/domain/entites/category_entity.dart';
import 'package:ecommerce_admin_app/features/categories/domain/repositories/categories_repo_.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCategoryUseCase {
  final CategoriesRepo repo;

  UpdateCategoryUseCase(this.repo);

  Future<Either<Failure, CategoryEntity>> invoke(
    int id,
    Map<String, dynamic> data,
  ) => repo.updateCategory(id, data);
}
