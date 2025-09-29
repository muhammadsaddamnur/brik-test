import 'package:dio/dio.dart';
import 'package:store/core/network/dio_client.dart';
import 'package:store/features/login/data/models/login_model.dart';

abstract class LoginRemoteDataSource {
  /// login
  Future<LoginModel> login({
    required String username,
    required String password,
  });
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final DioClient dioClient;

  LoginRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<LoginModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dioClient.post(
        '/login',
        data: {'username': 'admin', 'password': 'admin123'},
      );

      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
