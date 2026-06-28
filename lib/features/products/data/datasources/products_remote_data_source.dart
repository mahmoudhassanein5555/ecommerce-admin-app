import 'dart:typed_data';

import 'package:ecommerce_admin_app/features/products/data/models/products_dto.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductsDto>> getProducts({String? title});
  Future<ProductsDto> updateProduct(int id, Map<String, dynamic> data);
  Future<ProductsDto> addNewProduct(Map<String, dynamic> data);
  Future<bool> deleteProducts(int id);
  Future<String> uploadImage(Uint8List imageBytes, String fileName);
}
