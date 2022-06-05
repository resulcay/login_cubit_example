import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  bool isLoginFail = false;

  LoginCubit(this.formKey, this.emailController, this.passwordController)
      : super(LoginInitial());

  void postUserModel() {
    if (formKey.currentState?.validate() ?? false) {
      // TODO : Service
    } else {
      isLoginFail = true;
      LoginValidateState(isLoginFail);
    }
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginValidateState extends LoginState {
  final bool isValidate;

  LoginValidateState(this.isValidate);
}
