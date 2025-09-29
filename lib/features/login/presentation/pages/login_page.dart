import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/core/di/injection_container.dart';
import 'package:store/core/storage/local_storage.dart';
import 'package:store/core/widgets/button_widget.dart';
import 'package:store/core/widgets/loading_widget.dart';
import 'package:store/core/widgets/textfield_widget.dart';
import 'package:store/features/home/presentation/pages/home_page.dart';
import 'package:store/features/login/presentation/bloc/login_cubit.dart';
import 'package:store/features/login/presentation/bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginCubit = sl<LoginCubit>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  /// Save category to the database
  void login() {
    if (usernameController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please input username');
      return;
    }

    if (passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please input password');
      return;
    }

    loginCubit.login(username: usernameController.text, password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      body: SafeArea(
        child: BlocListener<LoginCubit, LoginState>(
          bloc: loginCubit,
          listener: (context, state) async {
            if (state is LoginLoadedState) {
              Fluttertoast.showToast(msg: 'Login success');
              await sl<LocalStorage>().saveUserLogin(loginModel: state.loginModel);

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(child: LoadingWidget()),
                TextfieldWidget(hint: 'Username', controller: usernameController),
                const SizedBox(height: 10),
                TextfieldWidget(hint: 'Password', controller: passwordController),
                const SizedBox(height: 10),
                ButtonWidget(text: 'Login', onPressed: login),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
