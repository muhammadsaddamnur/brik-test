import 'package:store/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:store/features/login/data/models/login_model.dart';
import 'package:store/features/login/domain/repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  Future<Either<Failure, LoginModel>> call({
    required String username,
    required String password,
  }) async {
    return await loginRepository.login(username: username, password: password);
  }
}
