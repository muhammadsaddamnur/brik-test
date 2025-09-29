import 'package:store/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:store/features/login/data/datasources/login_remote_datasource.dart';
import 'package:store/features/login/data/models/login_model.dart';
import 'package:store/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LoginModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      /// Login to remote data source
      final loginModel = await remoteDataSource.login(
        username: username,
        password: password,
      );

      return Right(loginModel);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
