import 'package:ecommerce_admin_app/core/api/api_endpoints.dart';
import 'package:ecommerce_admin_app/core/api/api_manager.dart';
import 'package:ecommerce_admin_app/core/errors/error.dart';
import 'package:ecommerce_admin_app/core/utils/shared_prefs_local_data_source.dart';
import 'package:ecommerce_admin_app/features/auth/data/datasources/login_data_source.dart';
import 'package:ecommerce_admin_app/features/auth/data/models/auth_dto_req.dart';
import 'package:ecommerce_admin_app/features/auth/data/models/auth_dto_res.dart';
import 'package:ecommerce_admin_app/features/auth/data/models/profile_data_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

@LazySingleton(as: LoginDataSource)
class LoginDataSourceImpl implements LoginDataSource {
  CacheHelper cacheHelper;
  LoginDataSourceImpl(this.cacheHelper);

  final apiManager = ApiManager();

  @override
  Future<LoginDtoRes> login(LoginDtoReq loginDtoReq) async {
    var response = await apiManager.postData(
      endPoint: ApiEndpoints.login,
      body: loginDtoReq.toJson(),
    );

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      final token = response.data['access_token'];
      
      // 1. حفظ التوكن بـ await
      await cacheHelper.saveData(key: 'access_token', value: token);

      // 2. فك التوكن واستخراج الـ user_id الصحيح
      if (token != null) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        await cacheHelper.saveData(key: 'user_id', value: decodedToken['sub']);
      }

      return LoginDtoRes.fromJson(response.data);
    } else {
      final errorMessage = response.data['message'];
      throw RemoteException(
        errorMessage is List ? errorMessage.join(", ") : errorMessage,
      );
    }
  }

  @override
  Future<ProfileDataDto> profileData() async {
    // 3. قراءة التوكن المباشر من الكاش للهيدر
    final token = cacheHelper.getData(key: 'access_token');

    var response = await apiManager.getData(
      endPoint: ApiEndpoints.profile,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      await cacheHelper.saveData(key: 'id', value: response.data['id']);
      await cacheHelper.saveData(key: 'name', value: response.data['name']);
      return ProfileDataDto.fromJson(response.data);
    } else {
      final errorMessage = response.data['message'];
      throw RemoteException(
        errorMessage is List ? errorMessage.join(", ") : errorMessage,
      );
    }
  }
}