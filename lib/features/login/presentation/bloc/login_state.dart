import 'package:equatable/equatable.dart';
import 'package:store/features/login/data/models/login_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {
  const LoginInitialState();
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

class LoginLoadedState extends LoginState {
  const LoginLoadedState({required this.loginModel});

  final LoginModel loginModel;

  @override
  List<Object?> get props => [loginModel];
}

class LoginErrorState extends LoginState {
  const LoginErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
