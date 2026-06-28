import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/products/domain/repositories/products_repo_.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadImageUseCase {
  final ProductsRepo productsRepo;

  UploadImageUseCase(this.productsRepo);

  Future<Either<Failure, String>> invoke(
    Uint8List imageBytes,
    String fileName,
  ) async {
    return await productsRepo.uploadImage(imageBytes, fileName);
  }
}
