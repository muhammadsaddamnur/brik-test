import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:store/core/error/failures.dart';
import 'package:store/features/login/data/models/login_model.dart';
import 'package:store/features/login/domain/repositories/login_repository.dart';
import 'package:store/features/login/domain/usecases/login_usecase.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  late LoginUseCase loginUseCase;
  late MockLoginRepository mockRepository;

  setUp(() {
    mockRepository = MockLoginRepository();
    loginUseCase = LoginUseCase(loginRepository: mockRepository);
  });

  group('LoginUseCase', () {
    final tUsername = 'testuser';
    final tPassword = 'password123';
    final tLoginModel = LoginModel(token: 'test_token');

    test('should login user from the repository', () async {
      // arrange
      when(mockRepository.login(username: tUsername, password: tPassword)).thenAnswer((_) async => Right(tLoginModel));

      // act
      final result = await loginUseCase(username: tUsername, password: tPassword);

      // assert
      expect(result, Right(tLoginModel));
      verify(mockRepository.login(username: tUsername, password: tPassword));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository returns failure', () async {
      // arrange
      final failure = ServerFailure(message: 'Invalid credentials');
      when(mockRepository.login(username: tUsername, password: tPassword)).thenAnswer((_) async => Left(failure));

      // act
      final result = await loginUseCase(username: tUsername, password: tPassword);

      // assert
      expect(result, Left(failure));
      verify(mockRepository.login(username: tUsername, password: tPassword));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
