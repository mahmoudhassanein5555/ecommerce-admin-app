import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class GetProductsEvent extends ProductsEvent {}

class AddProductEvent extends ProductsEvent {
  final Uint8List? selectedImageBytes1;
  final Uint8List? selectedImageBytes2;
  final Uint8List? selectedImageBytes3;
  final String? fileName1;
  final String? fileName2;
  final String? fileName3;
  final Map<String, dynamic> data;

  const AddProductEvent(
    this.data, {
    this.selectedImageBytes1,
    this.fileName1,
    this.selectedImageBytes2,
    this.selectedImageBytes3,
    this.fileName2,
    this.fileName3,
  });

  @override
  List<Object?> get props => [
    data,
    selectedImageBytes1,
    selectedImageBytes2,
    selectedImageBytes3,
    fileName1,
    fileName2,
    fileName3,
  ];
}

class UpdateProductEvent extends ProductsEvent {
  final int id;
  final Map<String, dynamic> data;
  final Uint8List? selectedImageBytes1;
  final Uint8List? selectedImageBytes2;
  final Uint8List? selectedImageBytes3;
  final String? fileName1;
  final String? fileName2;
  final String? fileName3;

  const UpdateProductEvent(
    this.id,
    this.data, {
    this.selectedImageBytes1,
    this.fileName1,
    this.selectedImageBytes2,
    this.selectedImageBytes3,
    this.fileName2,
    this.fileName3,
  });

  @override
  List<Object?> get props => [
    id,
    data,
    selectedImageBytes1,
    selectedImageBytes2,
    selectedImageBytes3,
    fileName1,
    fileName2,
    fileName3,
  ];
}

class DeleteProductEvent extends ProductsEvent {
  final int id;

  const DeleteProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class SearchProductsEvent extends ProductsEvent {
  final String query;

  const SearchProductsEvent(this.query);

  @override
  List<Object?> get props => [query];
}
