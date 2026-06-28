// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/datasources/login_data_source.dart' as _i605;
import '../../features/auth/data/datasources/login_data_source_impl.dart'
    as _i701;
import '../../features/auth/data/repository/login_repo_imp.dart' as _i201;
import '../../features/auth/domain/repositories/login_repo.dart' as _i502;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i37;
import '../../features/auth/presentation/view_model/login_bloc.dart' as _i542;
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

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.lazySingleton<_i605.LoginDataSource>(() => _i701.LoginDataSourceImpl());
    gh.lazySingleton<_i646.ProductsRemoteDataSource>(
      () => _i728.ProductsRemoteDataSourceImp(gh<_i1047.ApiManager>()),
    );
    gh.lazySingleton<_i502.LoginRepo>(
      () => _i201.LoginRepoImp(loginDataSource: gh<_i605.LoginDataSource>()),
    );
    gh.lazySingleton<_i1050.NetworkInfo>(() => _i1050.NetworkInfoImpl());
    gh.factory<_i37.LoginUseCase>(
      () => _i37.LoginUseCase(authRepo: gh<_i502.LoginRepo>()),
    );
    gh.lazySingleton<_i361.ProductsRepo>(
      () => _i581.ProductsRepoImp(
        gh<_i646.ProductsRemoteDataSource>(),
        gh<_i1050.NetworkInfo>(),
      ),
    );
    gh.factory<_i542.LoginBloc>(() => _i542.LoginBloc(gh<_i37.LoginUseCase>()));
    gh.factory<_i1054.UploadImageUseCase>(
      () => _i1054.UploadImageUseCase(gh<_i361.ProductsRepo>()),
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
    gh.factory<_i292.ProductsBloc>(
      () => _i292.ProductsBloc(
        getProductsUseCase: gh<_i846.GetProductsUseCase>(),
        deleteProductUseCase: gh<_i290.DeleteProductUseCase>(),
        addProductUseCase: gh<_i363.AddProductUseCase>(),
        updateProductUseCase: gh<_i796.UpdateProductUseCase>(),
        uploadImageUseCase: gh<_i1054.UploadImageUseCase>(),
      ),
    );
    return this;
  }
}
