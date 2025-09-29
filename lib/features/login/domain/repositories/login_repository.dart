import 'package:store/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:store/features/login/data/models/login_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginModel>> login({
    required String username,
    required String password,
  });
}
