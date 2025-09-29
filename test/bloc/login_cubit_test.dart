import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:store/core/error/failures.dart';
import 'package:store/features/login/data/models/login_model.dart';
import 'package:store/features/login/domain/usecases/login_usecase.dart';
import 'package:store/features/login/presentation/bloc/login_cubit.dart';
import 'package:store/features/login/presentation/bloc/login_state.dart';

import 'login_cubit_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  late LoginCubit loginCubit;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginCubit = LoginCubit(loginUseCase: mockLoginUseCase);
  });

  test('initial state should be LoginInitialState', () {
    expect(loginCubit.state, const LoginInitialState());
  });

  group('login', () {
    final tUsername = 'testuser';
    final tPassword = 'password123';
    final tLoginModel = LoginModel(token: 'test_token', user: User());

    test('should emit [LoginLoadingState, LoginLoadedState] when login is successful', () async {
      // arrange
      when(mockLoginUseCase(username: anyNamed('username'), password: anyNamed('password'))).thenAnswer((_) async => Right(tLoginModel));

      // assert later
      final expected = [const LoginLoadingState(), LoginLoadedState(loginModel: tLoginModel)];
      expectLater(loginCubit.stream, emitsInOrder(expected));

      // act
      await loginCubit.login(username: tUsername, password: tPassword);
    });

    test('should emit [LoginLoadingState, LoginErrorState] when login fails', () async {
      // arrange
      final failure = ServerFailure(message: 'Invalid credentials');
      when(mockLoginUseCase(username: anyNamed('username'), password: anyNamed('password'))).thenAnswer((_) async => Left(failure));

      // assert later
      final expected = [const LoginLoadingState(), LoginErrorState(message: failure.message)];
      expectLater(loginCubit.stream, emitsInOrder(expected));

      // act
      await loginCubit.login(username: tUsername, password: tPassword);
    });
  });
}
