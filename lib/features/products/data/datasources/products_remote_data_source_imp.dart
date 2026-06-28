import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ecommerce_admin_app/core/api/api_endpoints.dart';
import 'package:ecommerce_admin_app/core/api/api_manager.dart';
import 'package:ecommerce_admin_app/core/errors/error.dart';
import 'package:ecommerce_admin_app/features/products/data/datasources/products_remote_data_source.dart';
import 'package:ecommerce_admin_app/features/products/data/models/products_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductsRemoteDataSource)
class ProductsRemoteDataSourceImp implements ProductsRemoteDataSource {
  final ApiManager apiManager;
  ProductsRemoteDataSourceImp(this.apiManager);
  @override
  Future<ProductsDto> addNewProduct(Map<String, dynamic> data) async {
    var response = await apiManager.postData(
      endPoint: ApiEndpoints.products,
      body: data,
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return ProductsDto.fromJson(response.data);
    } else {
      throw RemoteException(response.statusMessage ?? "Unknown error");
    }
  }

  @override
  Future<bool> deleteProducts(int id) async {
    var response = await apiManager.deleteData(
      endPoint: "${ApiEndpoints.products}/$id",
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.data == null) {
        return true;
      }
      if (response.data is bool) {
        return response.data as bool;
      }
      if (response.data is Map<String, dynamic>) {
        if (response.data.containsKey('success')) {
          return response.data['success'] == true;
        }
        if (response.data.containsKey('status')) {
          return response.data['status'] == 'success';
        }
      }
      return true;
    } else {
      throw RemoteException(response.statusMessage ?? "Unknown error");
    }
  }

  @override
  Future<List<ProductsDto>> getProducts({String? title}) async {
    var response;
    if (title != null) {
      response = await apiManager.getData(
        endPoint: ApiEndpoints.products,
        queryParameters: {"title": title},
      );
    } else {
      response = await apiManager.getData(endPoint: ApiEndpoints.products);
    }
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      final List<dynamic> res = response.data;
      return res.map((e) => ProductsDto.fromJson(e)).toList();
    } else {
      throw RemoteException(response.statusMessage ?? "Unknown error");
    }
  }

  @override
  Future<ProductsDto> updateProduct(int id, Map<String, dynamic> data) async {
    var response = await apiManager.putData(
      endPoint: "${ApiEndpoints.products}/$id",
      body: data,
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return ProductsDto.fromJson(response.data);
    } else {
      throw RemoteException(response.statusMessage ?? "Unknown error");
    }
  }

  @override
  Future<String> uploadImage(Uint8List imageBytes, String fileName) async {
    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(imageBytes, filename: fileName),
    });
    var response = await apiManager.postData(
      endPoint: ApiEndpoints.upload,
      body: formData,
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      String imageUrl = response.data["location"];
      return imageUrl;
    } else {
      throw RemoteException(response.statusMessage ?? "Unknown error");
    }
  }
}
