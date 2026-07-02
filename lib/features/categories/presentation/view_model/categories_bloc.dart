import 'package:ecommerce_admin_app/features/categories/domain/entites/category_entity.dart';
import 'package:ecommerce_admin_app/features/categories/domain/usecases/add_category_use_case.dart';
import 'package:ecommerce_admin_app/features/categories/domain/usecases/delete_category_use_case.dart';
import 'package:ecommerce_admin_app/features/categories/domain/usecases/get_categories_use_case.dart';
import 'package:ecommerce_admin_app/features/categories/domain/usecases/get_products_by_category_use_case.dart';
import 'package:ecommerce_admin_app/features/categories/domain/usecases/update_category_use_case.dart';
import 'package:ecommerce_admin_app/features/categories/presentation/view_model/categories_event.dart';
import 'package:ecommerce_admin_app/features/categories/presentation/view_model/categories_state.dart';
import 'package:ecommerce_admin_app/features/products/domain/usecases/upload_image_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final AddCategoryUseCase addCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;
  final UploadImageUseCase uploadImageUseCase;
  bool hasError = false;
  int i = 0;

  CategoriesBloc({
    required this.getCategoriesUseCase,
    required this.addCategoryUseCase,
    required this.updateCategoryUseCase,
    required this.deleteCategoryUseCase,
    required this.getProductsByCategoryUseCase,
    required this.uploadImageUseCase,
  }) : super(CategoriesInitial()) {
    List<CategoryEntity> currentCategories = [];

    on<GetCategoriesEvent>((event, emit) async {
      emit(CategoriesLoading());
      final result = await getCategoriesUseCase.invoke();
      result.fold((failure) => emit(CategoriesError(failure.failuremessage)), (
        categories,
      ) {
        emit(GetCategoriesSuccess(categories));
        currentCategories = categories;
      });
    });

    on<AddCategoryEvent>((event, emit) async {
      if (i == 0 &&
          event.selectedImageBytes != null &&
          event.fileName != null) {
        final res = await uploadImageUseCase.invoke(
          event.selectedImageBytes!,
          event.fileName!,
        );
        res.fold(
          (failure) {
            hasError = true;
            emit(CategoriesError(failure.failuremessage));
          },
          (imageLink) {
            event.data['image'] = imageLink;
          },
        );
      }
      if (hasError) {
        return;
      }
      emit(CategoriesLoading());
      final result = await addCategoryUseCase.invoke(event.data);
      result.fold((failure) => emit(CategoriesError(failure.failuremessage)), (
        category,
      ) {
        emit(AddCategorySuccess(category));
        currentCategories.add(category);
        emit(GetCategoriesSuccess(currentCategories));
      });
    });

    on<UpdateCategoryEvent>((event, emit) async {
      if (i == 0 &&
          event.selectedImageBytes != null &&
          event.fileName != null) {
        final res = await uploadImageUseCase.invoke(
          event.selectedImageBytes!,
          event.fileName!,
        );
        res.fold(
          (failure) {
            hasError = true;
            emit(CategoriesError(failure.failuremessage));
          },
          (imageLink) {
            event.data['image'] = imageLink;
          },
        );
      }
      if (hasError) {
        return;
      }
      final result = await updateCategoryUseCase.invoke(event.id, event.data);
      result.fold((failure) => emit(CategoriesError(failure.failuremessage)), (
        category,
      ) {
        final index = currentCategories.indexWhere(
          (item) => item.id == category.id,
        );
        if (index != -1) {
          currentCategories[index] = category;
        }

        emit(UpdateCategorySuccess(category));
        emit(GetCategoriesSuccess(currentCategories));
      });
    });

    on<DeleteCategoryEvent>((event, emit) async {
      final result = await deleteCategoryUseCase.invoke(event.id);
      result.fold((failure) => emit(CategoriesError(failure.failuremessage)), (
        isDeleted,
      ) {
        emit(DeleteCategorySuccess(isDeleted));
        currentCategories.removeWhere((item) => item.id == event.id);
        emit(GetCategoriesSuccess(currentCategories));
      });
    });

    on<GetProductsByCategoryEvent>((event, emit) async {
      emit(CategoriesLoading());
      var result = await getProductsByCategoryUseCase.invoke(event.id);
      result.fold(
        (failure) => emit(CategoriesError(failure.failuremessage)),
        (products) => emit(GetProductsByCategorySuccess(products)),
      );
    });
  }
}
