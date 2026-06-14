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
import '../api/api_manager.dart' as _i1047;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.lazySingleton<_i605.LoginDataSource>(() => _i701.LoginDataSourceImpl());
    gh.lazySingleton<_i502.LoginRepo>(
      () => _i201.LoginRepoImp(loginDataSource: gh<_i605.LoginDataSource>()),
    );
    gh.factory<_i37.LoginUseCase>(
      () => _i37.LoginUseCase(authRepo: gh<_i502.LoginRepo>()),
    );
    gh.factory<_i542.LoginBloc>(() => _i542.LoginBloc(gh<_i37.LoginUseCase>()));
    return this;
  }
}
