import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/login/domain/usecases/login_usecase.dart';
import 'package:store/features/login/presentation/bloc/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(const LoginInitialState());

  /// Login user
  Future<void> login({required String username, required String password}) async {
    emit(const LoginLoadingState());
    final result = await loginUseCase(username: '', password: '');
    result.fold((failure) => emit(LoginErrorState(message: failure.message)), (success) => emit(LoginLoadedState(loginModel: success)));
  }
}
