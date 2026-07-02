import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCategoriesEvent extends CategoriesEvent {}

// class GetCategoryByIdEvent extends CategoriesEvent {
//   final int id;

//   GetCategoryByIdEvent(this.id);
//   @override
//   List<Object?> get props => [id];
// }

// class GetCategoryBySlugEvent extends CategoriesEvent {
//   final String slug;

//   GetCategoryBySlugEvent(this.slug);
//   @override
//   List<Object?> get props => [slug];
// }

class AddCategoryEvent extends CategoriesEvent {
  final Map<String, dynamic> data;
  final Uint8List? selectedImageBytes;
  final String? fileName;

  AddCategoryEvent(this.data, {this.selectedImageBytes, this.fileName});
  @override
  List<Object?> get props => [data];
}

class UpdateCategoryEvent extends CategoriesEvent {
  final int id;
  final Map<String, dynamic> data;
  final Uint8List? selectedImageBytes;
  final String? fileName;

  UpdateCategoryEvent(
    this.id,
    this.data, {
    this.selectedImageBytes,
    this.fileName,
  });
  @override
  List<Object?> get props => [id, data];
}

class DeleteCategoryEvent extends CategoriesEvent {
  final int id;

  DeleteCategoryEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class GetProductsByCategoryEvent extends CategoriesEvent {
  final int id;

  GetProductsByCategoryEvent(this.id);
  @override
  List<Object?> get props => [id];
}
