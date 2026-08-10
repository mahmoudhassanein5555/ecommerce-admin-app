// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/datasources/login_data_source.dart' as _i605;
import '../../features/auth/data/datasources/login_data_source_impl.dart'
    as _i701;
import '../../features/auth/data/repository/login_repo_imp.dart' as _i201;
import '../../features/auth/domain/repositories/login_repo.dart' as _i502;
import '../../features/auth/domain/usecases/get_profile_data_use_case.dart'
    as _i910;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i37;
import '../../features/auth/presentation/view_model/login_bloc.dart' as _i542;
import '../../features/categories/data/datasources/categories_remote_data_source.dart'
    as _i814;
import '../../features/categories/data/datasources/categories_remote_data_source_imp.dart'
    as _i929;
import '../../features/categories/data/repository/categories_repo_imp.dart'
    as _i828;
import '../../features/categories/domain/repositories/categories_repo_.dart'
    as _i525;
import '../../features/categories/domain/usecases/add_category_use_case.dart'
    as _i809;
import '../../features/categories/domain/usecases/delete_category_use_case.dart'
    as _i729;
import '../../features/categories/domain/usecases/get_categories_use_case.dart'
    as _i308;
import '../../features/categories/domain/usecases/get_products_by_category_use_case.dart'
    as _i573;
import '../../features/categories/domain/usecases/update_category_use_case.dart'
    as _i610;
import '../../features/categories/presentation/view_model/categories_bloc.dart'
    as _i171;
import '../../features/chats/data/data_source/chats_data_source.dart' as _i0;
import '../../features/chats/data/data_source/chats_data_source_imp.dart'
    as _i316;
import '../../features/chats/data/repository/chat_repo_imp.dart' as _i713;
import '../../features/chats/domain/repository/chat_repo.dart' as _i438;
import '../../features/chats/domain/use_case/get_chat_messages_use_case.dart'
    as _i113;
import '../../features/chats/domain/use_case/get_chat_rooms_use_case.dart'
    as _i720;
import '../../features/chats/domain/use_case/seng_message_use_case.dart'
    as _i439;
import '../../features/chats/presentation/view_model/chats_bloc.dart' as _i42;
import '../../features/customers/data/datasources/users_remote_data_source.dart'
    as _i722;
import '../../features/customers/data/datasources/users_remote_data_source_imp.dart'
    as _i545;
import '../../features/customers/data/repository/users_repo_imp.dart' as _i415;
import '../../features/customers/domain/repositories/users_repo.dart' as _i649;
import '../../features/customers/domain/usecases/check_email_availability_use_case.dart'
    as _i256;
import '../../features/customers/domain/usecases/create_user_use_case.dart'
    as _i696;
import '../../features/customers/domain/usecases/get_user_by_id_use_case.dart'
    as _i924;
import '../../features/customers/domain/usecases/get_users_use_case.dart'
    as _i985;
import '../../features/customers/presentation/view_model/customers_bloc.dart'
    as _i1018;
import '../../features/orders/data/data_source/orders_data_source.dart'
    as _i872;
import '../../features/orders/data/data_source/orders_data_source_imp.dart'
    as _i337;
import '../../features/orders/data/repository/order_repo_imp.dart' as _i21;
import '../../features/orders/domain/repository/orders_repo.dart' as _i132;
import '../../features/orders/domain/use_case/get_orders_use_case.dart'
    as _i590;
import '../../features/orders/presentation/view_model/orders_bloc.dart'
    as _i840;
import '../../features/products/data/datasources/products_remote_data_source.dart'
    as _i646;
import '../../features/products/data/datasources/products_remote_data_source_imp.dart'
    as _i728;
import '../../features/products/data/repository/products_repo_imp.dart'
    as _i581;
import '../../features/products/domain/repositories/products_repo_.dart'
    as _i361;
import '../../features/products/domain/usecases/add_product_use_case.dart'
    as _i363;
import '../../features/products/domain/usecases/delete_product_use_case.dart'
    as _i290;
import '../../features/products/domain/usecases/get_products_use_case.dart'
    as _i846;
import '../../features/products/domain/usecases/update_product_use_case.dart'
    as _i796;
import '../../features/products/domain/usecases/upload_image_use_case.dart'
    as _i1054;
import '../../features/products/presentation/view_model/products_bloc.dart'
    as _i292;
import '../api/api_manager.dart' as _i1047;
import '../network/connection_checker.dart' as _i1050;
import '../utils/shared_prefs_local_data_source.dart' as _i336;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.sharedPrefs,
      preResolve: true,
    );
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.lazySingleton<_i646.ProductsRemoteDataSource>(
      () => _i728.ProductsRemoteDataSourceImp(gh<_i1047.ApiManager>()),
    );
    gh.lazySingleton<_i722.UsersRemoteDataSource>(
      () => _i545.UsersRemoteDataSourceImp(gh<_i1047.ApiManager>()),
    );
    gh.lazySingleton<_i1050.NetworkInfo>(() => _i1050.NetworkInfoImpl());
    gh.lazySingleton<_i0.ChatDataSource>(() => _i316.ChatDataSourceImp());
    gh.lazySingleton<_i814.CategoriesRemoteDataSource>(
      () => _i929.CategoriesRemoteDataSourceImp(gh<_i1047.ApiManager>()),
    );
    gh.lazySingleton<_i649.UsersRepo>(
      () => _i415.UsersRepoImp(
        gh<_i722.UsersRemoteDataSource>(),
        gh<_i1050.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i438.ChatRepo>(
      () => _i713.ChatRepoImp(chatDataSource: gh<_i0.ChatDataSource>()),
    );
    gh.lazySingleton<_i336.CacheHelper>(
      () => _i336.CacheHelper(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i525.CategoriesRepo>(
      () => _i828.CategoriesRepoImp(
        gh<_i814.CategoriesRemoteDataSource>(),
        gh<_i1050.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i872.OrdersDataSource>(
      () => _i337.OrdersDataSourceImp(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i113.GetChatMessagesUseCase>(
      () => _i113.GetChatMessagesUseCase(gh<_i438.ChatRepo>()),
    );
    gh.factory<_i720.GetChatRoomsUseCase>(
      () => _i720.GetChatRoomsUseCase(gh<_i438.ChatRepo>()),
    );
    gh.factory<_i439.SengMessageUseCase>(
      () => _i439.SengMessageUseCase(gh<_i438.ChatRepo>()),
    );
    gh.lazySingleton<_i605.LoginDataSource>(
      () => _i701.LoginDataSourceImpl(gh<_i336.CacheHelper>()),
    );
    gh.factory<_i42.ChatsBloc>(
      () => _i42.ChatsBloc(
        gh<_i720.GetChatRoomsUseCase>(),
        gh<_i113.GetChatMessagesUseCase>(),
        gh<_i439.SengMessageUseCase>(),
      ),
    );
    gh.lazySingleton<_i502.LoginRepo>(
      () => _i201.LoginRepoImp(loginDataSource: gh<_i605.LoginDataSource>()),
    );
    gh.lazySingleton<_i361.ProductsRepo>(
      () => _i581.ProductsRepoImp(
        gh<_i646.ProductsRemoteDataSource>(),
        gh<_i1050.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i132.OrdersRepo>(
      () => _i21.OrderRepoImp(gh<_i872.OrdersDataSource>()),
    );
    gh.factory<_i256.CheckEmailAvailabilityUseCase>(
      () => _i256.CheckEmailAvailabilityUseCase(gh<_i649.UsersRepo>()),
    );
    gh.factory<_i696.CreateUserUseCase>(
      () => _i696.CreateUserUseCase(gh<_i649.UsersRepo>()),
    );
    gh.factory<_i924.GetUserByIdUseCase>(
      () => _i924.GetUserByIdUseCase(gh<_i649.UsersRepo>()),
    );
    gh.factory<_i985.GetUsersUseCase>(
      () => _i985.GetUsersUseCase(gh<_i649.UsersRepo>()),
    );
    gh.factory<_i809.AddCategoryUseCase>(
      () => _i809.AddCategoryUseCase(gh<_i525.CategoriesRepo>()),
    );
    gh.factory<_i729.DeleteCategoryUseCase>(
      () => _i729.DeleteCategoryUseCase(gh<_i525.CategoriesRepo>()),
    );
    gh.factory<_i308.GetCategoriesUseCase>(
      () => _i308.GetCategoriesUseCase(gh<_i525.CategoriesRepo>()),
    );
    gh.factory<_i573.GetProductsByCategoryUseCase>(
      () => _i573.GetProductsByCategoryUseCase(gh<_i525.CategoriesRepo>()),
    );
    gh.factory<_i610.UpdateCategoryUseCase>(
      () => _i610.UpdateCategoryUseCase(gh<_i525.CategoriesRepo>()),
    );
    gh.factory<_i590.GetOrdersUseCase>(
      () => _i590.GetOrdersUseCase(gh<_i132.OrdersRepo>()),
    );
    gh.factory<_i1018.CustomersBloc>(
      () => _i1018.CustomersBloc(
        getUsersUseCase: gh<_i985.GetUsersUseCase>(),
        getUserByIdUseCase: gh<_i924.GetUserByIdUseCase>(),
        checkEmailAvailabilityUseCase:
            gh<_i256.CheckEmailAvailabilityUseCase>(),
        createUserUseCase: gh<_i696.CreateUserUseCase>(),
      ),
    );
    gh.factory<_i1054.UploadImageUseCase>(
      () => _i1054.UploadImageUseCase(gh<_i361.ProductsRepo>()),
    );
    gh.factory<_i910.GetProfileDataUseCase>(
      () => _i910.GetProfileDataUseCase(authRepo: gh<_i502.LoginRepo>()),
    );
    gh.factory<_i37.LoginUseCase>(
      () => _i37.LoginUseCase(authRepo: gh<_i502.LoginRepo>()),
    );
    gh.factory<_i363.AddProductUseCase>(
      () => _i363.AddProductUseCase(gh<_i361.ProductsRepo>()),
    );
    gh.factory<_i290.DeleteProductUseCase>(
      () => _i290.DeleteProductUseCase(gh<_i361.ProductsRepo>()),
    );
    gh.factory<_i846.GetProductsUseCase>(
      () => _i846.GetProductsUseCase(gh<_i361.ProductsRepo>()),
    );
    gh.factory<_i796.UpdateProductUseCase>(
      () => _i796.UpdateProductUseCase(gh<_i361.ProductsRepo>()),
    );
    gh.factory<_i840.OrdersBloc>(
      () => _i840.OrdersBloc(gh<_i590.GetOrdersUseCase>()),
    );
    gh.factory<_i171.CategoriesBloc>(
      () => _i171.CategoriesBloc(
        getCategoriesUseCase: gh<_i308.GetCategoriesUseCase>(),
        addCategoryUseCase: gh<_i809.AddCategoryUseCase>(),
        updateCategoryUseCase: gh<_i610.UpdateCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i729.DeleteCategoryUseCase>(),
        getProductsByCategoryUseCase: gh<_i573.GetProductsByCategoryUseCase>(),
        uploadImageUseCase: gh<_i1054.UploadImageUseCase>(),
      ),
    );
    gh.factory<_i292.ProductsBloc>(
      () => _i292.ProductsBloc(
        getProductsUseCase: gh<_i846.GetProductsUseCase>(),
        deleteProductUseCase: gh<_i290.DeleteProductUseCase>(),
        addProductUseCase: gh<_i363.AddProductUseCase>(),
        updateProductUseCase: gh<_i796.UpdateProductUseCase>(),
        uploadImageUseCase: gh<_i1054.UploadImageUseCase>(),
      ),
    );
    gh.factory<_i542.LoginBloc>(
      () => _i542.LoginBloc(
        gh<_i37.LoginUseCase>(),
        gh<_i910.GetProfileDataUseCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i336.AppModule {}
