import 'package:ecommerce_admin_app/features/products/domain/entites/products_entity.dart';
import 'package:ecommerce_admin_app/features/products/domain/usecases/add_product_use_case.dart';
import 'package:ecommerce_admin_app/features/products/domain/usecases/delete_product_use_case.dart';
import 'package:ecommerce_admin_app/features/products/domain/usecases/get_products_use_case.dart';
import 'package:ecommerce_admin_app/features/products/domain/usecases/update_product_use_case.dart';
import 'package:ecommerce_admin_app/features/products/domain/usecases/upload_image_use_case.dart';
import 'package:ecommerce_admin_app/features/products/presentation/view_model/products_event.dart';
import 'package:ecommerce_admin_app/features/products/presentation/view_model/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase getProductsUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final AddProductUseCase addProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final UploadImageUseCase uploadImageUseCase;
  List<ProductsEntity> _currentProducts = [];
  ProductsBloc({
    required this.getProductsUseCase,
    required this.deleteProductUseCase,
    required this.addProductUseCase,
    required this.updateProductUseCase,
    required this.uploadImageUseCase,
  }) : super(ProductsInitial()) {
    on<GetProductsEvent>((event, emit) async {
      emit(ProductsLoading());
      final result = await getProductsUseCase.invoke();

      result.fold((failure) => emit(ProductsError(failure.failuremessage)), (
        products,
      ) {
        _currentProducts = List.from(products);
        emit(GetProductsSuccess(_currentProducts));
      });
    });
    on<SearchProductsEvent>((event, emit) async {
      final result = await getProductsUseCase.invoke(title: event.query);

      result.fold((failure) => emit(ProductsError(failure.failuremessage)), (
        products,
      ) {
        if (products.isEmpty) {
          emit(const SearchProductsEmpty("No results found"));
          return;
        }
        _currentProducts = List.from(products);
        emit(GetProductsSuccess(_currentProducts));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
    on<UpdateProductEvent>((event, emit) async {
      bool hasError = false;
      for (var i = 0; i < 3; i++) {
        if (i == 0 &&
            event.selectedImageBytes1 != null &&
            event.fileName1 != null) {
          final res = await uploadImageUseCase.invoke(
            event.selectedImageBytes1!,
            event.fileName1!,
          );
          res.fold(
            (failure) {
              hasError = true;
              emit(ProductsError(failure.failuremessage));
            },
            (imageLink) {
              event.data['images'][0] = imageLink;
            },
          );
          if (hasError) {
            break;
          }
        } else if (i == 1 &&
            event.selectedImageBytes2 != null &&
            event.fileName2 != null) {
          final res = await uploadImageUseCase.invoke(
            event.selectedImageBytes2!,
            event.fileName2!,
          );
          res.fold(
            (failure) {
              hasError = true;
              emit(ProductsError(failure.failuremessage));
            },
            (imageLink) {
              event.data['images'][1] = imageLink;
            },
          );
          if (hasError) {
            break;
          }
        } else if (i == 2 &&
            event.selectedImageBytes3 != null &&
            event.fileName3 != null) {
          final res = await uploadImageUseCase.invoke(
            event.selectedImageBytes3!,
            event.fileName3!,
          );
          res.fold(
            (failure) {
              hasError = true;
              emit(ProductsError(failure.failuremessage));
            },
            (imageLink) {
              event.data['images'][2] = imageLink;
            },
          );
          if (hasError) {
            break;
          }
        }
      }
      if (hasError) {
        return;
      }
      event.data['images'] = (event.data["images"] as List)
          .whereType<String>()
          .toList();
      final result = await updateProductUseCase.invoke(event.id, event.data);

      result.fold((failure) => emit(ProductsError(failure.failuremessage)), (
        product,
      ) {
        final index = _currentProducts.indexWhere(
          (item) => item.id == product.id,
        );
        if (index != -1) {
          _currentProducts[index] = product;
        }
        emit(UpdateProductSuccess(product));
        emit(GetProductsSuccess(List.from(_currentProducts)));
      });
    });
    on<AddProductEvent>((event, emit) async {
      bool hasError = false;
      for (var i = 0; i < 3; i++) {
        if (i == 0 &&
            event.selectedImageBytes1 != null &&
            event.fileName1 != null) {
          final res = await uploadImageUseCase.invoke(
            event.selectedImageBytes1!,
            event.fileName1!,
          );
          res.fold(
            (failure) {
              hasError = true;
              emit(ProductsError(failure.failuremessage));
            },
            (imageLink) {
              event.data['images'][0] = imageLink;
            },
          );
          if (hasError) {
            break;
          }
        } else if (i == 1 &&
            event.selectedImageBytes2 != null &&
            event.fileName2 != null) {
          final res = await uploadImageUseCase.invoke(
            event.selectedImageBytes2!,
            event.fileName2!,
          );
          res.fold(
            (failure) {
              hasError = true;
              emit(ProductsError(failure.failuremessage));
            },
            (imageLink) {
              event.data['images'][1] = imageLink;
            },
          );
          if (hasError) {
            break;
          }
        } else if (i == 2 &&
            event.selectedImageBytes3 != null &&
            event.fileName3 != null) {
          final res = await uploadImageUseCase.invoke(
            event.selectedImageBytes3!,
            event.fileName3!,
          );
          res.fold(
            (failure) {
              hasError = true;
              emit(ProductsError(failure.failuremessage));
            },
            (imageLink) {
              event.data['images'][2] = imageLink;
            },
          );
          if (hasError) {
            break;
          }
        }
      }
      if (hasError) {
        return;
      }
      event.data['images'] = (event.data["images"] as List)
          .whereType<String>()
          .toList();
      final result = await addProductUseCase.invoke(event.data);

      result.fold((failure) => emit(ProductsError(failure.failuremessage)), (
        product,
      ) {
        _currentProducts.add(product);
        emit(AddProductSuccess(product));
        emit(GetProductsSuccess(List.from(_currentProducts)));
      });
    });
    on<DeleteProductEvent>((event, emit) async {
      final result = await deleteProductUseCase.invoke(event.id);

      result.fold((failure) => emit(ProductsError(failure.failuremessage)), (
        isDeleted,
      ) {
        if (isDeleted) {
          _currentProducts.removeWhere((element) => element.id == event.id);
          emit(const DeleteProductSuccess(true));
          emit(GetProductsSuccess(List.from(_currentProducts)));
        } else {
          emit(const ProductsError('Unable to delete product.'));
        }
      });
    }, transformer: throttleDuration(const Duration(milliseconds: 1500)));
  }
}

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}

EventTransformer<Event> throttleDuration<Event>(Duration duration) {
  return (events, mapper) => events.throttleTime(duration).flatMap(mapper);
}
