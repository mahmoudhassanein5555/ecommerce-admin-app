import 'package:ecommerce_admin_app/core/api/api_endpoints.dart';
import 'package:ecommerce_admin_app/core/api/api_manager.dart';
import 'package:ecommerce_admin_app/core/errors/error.dart';
import 'package:ecommerce_admin_app/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:ecommerce_admin_app/features/categories/data/models/categories_dto.dart';
import 'package:ecommerce_admin_app/features/products/data/models/products_dto.dart';
import 'package:ecommerce_admin_app/features/products/domain/entites/products_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoriesRemoteDataSource)
class CategoriesRemoteDataSourceImp implements CategoriesRemoteDataSource {
  final ApiManager apiManager;

  CategoriesRemoteDataSourceImp(this.apiManager);

  @override
  Future<List<dynamic>> getCategories() async {
    final response = await apiManager.getData(
      endPoint: ApiEndpoints.categories,
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return (response.data as List)
          .map((e) => CategoriesDto.fromJson(e))
          .toList();
    }
    throw RemoteException(response.statusMessage ?? 'Unknown error');
  }

  @override
  Future<dynamic> addCategory(Map<String, dynamic> data) async {
    final response = await apiManager.postData(
      endPoint: ApiEndpoints.categories,
      body: data,
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return CategoriesDto.fromJson(response.data);
    }
    throw RemoteException(response.statusMessage ?? 'Unknown error');
  }

  @override
  Future<dynamic> updateCategory(int id, Map<String, dynamic> data) async {
    final response = await apiManager.putData(
      endPoint: '${ApiEndpoints.categories}/$id',
      body: data,
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return CategoriesDto.fromJson(response.data);
    }
    throw RemoteException(response.statusMessage ?? 'Unknown error');
  }

  @override
  Future<bool> deleteCategory(int id) async {
    final response = await apiManager.deleteData(
      endPoint: '${ApiEndpoints.categories}/$id',
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return true;
    }
    throw RemoteException(response.statusMessage ?? 'Unknown error');
  }

  @override
  Future<List<ProductsEntity>> getProductsByCategory(int id) async {
    final response = await apiManager.getData(
      endPoint: '${ApiEndpoints.categories}/$id/products',
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      final dynamic rawData = response.data;
      List<dynamic> items = [];

      if (rawData is List) {
        items = rawData;
      } else if (rawData is Map<String, dynamic>) {
        if (rawData['data'] is List) {
          items = rawData['data'] as List<dynamic>;
        } else if (rawData['products'] is List) {
          items = rawData['products'] as List<dynamic>;
        } else if (rawData['items'] is List) {
          items = rawData['items'] as List<dynamic>;
        } else if (rawData['results'] is List) {
          items = rawData['results'] as List<dynamic>;
        }
      }

      return items
          .map((item) => ProductsDto.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    throw RemoteException(response.statusMessage ?? 'Unknown error');
  }
}
