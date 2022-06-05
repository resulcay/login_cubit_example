import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_cubit_example/login/service/login_service.dart';
import 'package:login_cubit_example/login/viewmodel/login_cubit.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String baseUrl = "https://reqres.in/api";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        formKey,
        passwordController,
        emailController,
        service: LoginService(
          Dio(
            BaseOptions(baseUrl: baseUrl),
          ),
        ),
      ),
      child: BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          return buildScaffold(context, state);
        },
        listener: (context, state) {},
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, LoginState state) {
    return Scaffold(
      appBar: AppBar(
        leading: Visibility(
            visible: context.watch<LoginCubit>().isLoading,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                  backgroundColor: Colors.amberAccent),
            )),
        centerTitle: true,
        title: const Text(
          "Cubit Login",
        ),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: autovalidateMode(state),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextFormFieldMail(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            buildTextFormFieldPassword(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<LoginCubit>().postUserModel();
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }

  AutovalidateMode autovalidateMode(LoginState state) {
    return state is LoginValidateState
        ? (state.isValidate
            ? AutovalidateMode.always
            : AutovalidateMode.disabled)
        : AutovalidateMode.disabled;
  }

  TextFormField buildTextFormFieldPassword() {
    return TextFormField(
      controller: passwordController,
      // controller: context.read<LoginCubit>().passwordController,
      validator: (val) =>
          (val ?? "").length > 5 ? null : "can not be lower than 5",
      decoration: const InputDecoration(
        labelText: "Password",
        border: OutlineInputBorder(),
      ),
    );
  }

  TextFormField buildTextFormFieldMail() {
    return TextFormField(
      controller: emailController,
      //  controller: context.read<LoginCubit>().emailController,
      validator: (val) =>
          (val ?? "").length > 5 ? null : "can not be lower than 6",
      decoration: const InputDecoration(
        labelText: "E-mail",
        border: OutlineInputBorder(),
      ),
    );
  }
}
