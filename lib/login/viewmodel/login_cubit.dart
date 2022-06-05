import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_cubit_example/login/model/login_request_model.dart';
import 'package:login_cubit_example/login/model/token_model.dart';
import 'package:login_cubit_example/login/service/i_login_service.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  bool isLoginFail = false;
  bool isLoading = false;
  final ILoginService service;

  LoginCubit(this.formKey, this.emailController, this.passwordController,
      {required this.service})
      : super(LoginInitial());

  Future<void> postUserModel() async {
    changeLoadingView();
    Future.delayed(const Duration(seconds: 2));
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      final data = await service.postUserLogin(
        LoginRequestModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
      if (data is Token) {
        emit(LoginComplete(data));
      }
    } else {
      isLoginFail = true;
      LoginValidateState(isLoginFail);
      emit(LoginValidateState(isLoginFail));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginComplete extends LoginState {
  final Token token;

  LoginComplete(this.token);
}

class LoginValidateState extends LoginState {
  final bool isValidate;

  LoginValidateState(this.isValidate);
}

class LoginLoadingState extends LoginState {
  final bool isLoading;

  LoginLoadingState(this.isLoading);
}
