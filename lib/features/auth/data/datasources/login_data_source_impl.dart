import 'package:ecommerce_admin_app/core/api/api_endpoints.dart';
import 'package:ecommerce_admin_app/core/api/api_manager.dart';
import 'package:ecommerce_admin_app/features/auth/data/datasources/login_data_source.dart';
import 'package:ecommerce_admin_app/features/auth/data/models/auth_dto_req.dart';
import 'package:ecommerce_admin_app/features/auth/data/models/auth_dto_res.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoginDataSource)
class LoginDataSourceImpl implements LoginDataSource {
  @override
  Future<LoginDtoRes> login(LoginDtoReq loginDtoReq) async {
    final apiManager = ApiManager();
    var response = await apiManager.postData(
      endPoint: ApiEndpoints.login,
      body: loginDtoReq.toJson(),
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return LoginDtoRes.fromJson(response.data);
    } else {
      final errorMessage = response.data['message'];
      throw Exception(
        errorMessage is List ? errorMessage.join(", ") : errorMessage,
      );
    }
  }
}
