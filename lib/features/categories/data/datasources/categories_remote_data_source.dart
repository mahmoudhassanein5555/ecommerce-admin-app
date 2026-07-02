import 'package:ecommerce_admin_app/features/products/domain/entites/products_entity.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<dynamic>> getCategories();
  Future<dynamic> addCategory(Map<String, dynamic> data);
  Future<dynamic> updateCategory(int id, Map<String, dynamic> data);
  Future<bool> deleteCategory(int id);
  Future<List<ProductsEntity>> getProductsByCategory(int id);
}
